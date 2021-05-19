import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/articles/acquireArticleModel.dart';
import '../../models/articles/articleModel.dart';
import '../../models/articles/imageModel.dart';
import '../globals/constants/constants.dart';

class ArticlesRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future postArticle(ImageModel image, String uId) async {
    try {
      TaskSnapshot taskSnapshot = await _storage
          .ref()
          .child('${DatabaseChild.articles_Img}/${image.articleName}')
          .putFile(image.file);

      if (taskSnapshot.state == TaskState.success) {
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        var article = ArticleModel(
            url: downloadUrl,
            description: image.description,
            articleName: image.articleName,
            contactUId: uId,
            uId: uId);

        await _database
            .reference()
            .child(DatabaseChild.available_articles)
            .push()
            .set(article.toJson());

        await _database
            .reference()
            .child(DatabaseChild.published_articles)
            .push()
            .set(article.toJson());

        return Response.success;
      } else {
        print('Error from image repo ${taskSnapshot.state.toString()}');
        throw ('This file is not an image');
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllArticles() async {
    var list = [];

    try {
      await _database
          .reference()
          .child(DatabaseChild.available_articles)
          .once()
          .then((resp) {
        Map<dynamic, dynamic> values = resp.value;

        values.forEach((key, values) => list.add(values));
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    return list;
  }

  Future postAcquireArticle(AcquireArticleModel article) async {
    try {
      var node = await _getPublishedArticleNodeValueByUId(article.url);

      await _database
          .reference()
          .child(DatabaseChild.acquired_articles)
          .push()
          .set(article.toJson());

      await _database
          .reference()
          .child('${DatabaseChild.available_articles}/$node')
          .remove();

      return Response.success;
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future getObtainedArticleByUid(String uId) async {
    var list = [];

    try {
      await _database
          .reference()
          .child(DatabaseChild.acquired_articles) // node
          .orderByChild(DatabaseChild.uId) // property
          .equalTo(uId)
          .once()
          .then((snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;

        values.forEach((key, values) => list.add(values));
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    return list;
  }

  Future getPublishedArticlesByUid(String uId) async {
    var list = [];

    try {
      await _database
          .reference()
          .child(DatabaseChild.published_articles) // node
          .orderByChild(DatabaseChild.uId) // property
          .equalTo(uId)
          .once()
          .then((snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;

        values.forEach((key, values) => list.add(values));
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }

    return list;
  }

  _getPublishedArticleNodeValueByUId(String url) async {
    try {
      var data = await _database
          .reference()
          .child(DatabaseChild.available_articles) // node
          .orderByChild(DatabaseChild.url) // property
          .equalTo(url)
          .once()
          .then((DataSnapshot snapshot) {
        final value = snapshot.value as Map;

        return value.keys
            .toString()
            .replaceFirst('(', '')
            .replaceFirst(')', '');
      });

      return data;
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
