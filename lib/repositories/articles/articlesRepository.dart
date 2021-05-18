import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/articles/articleModel.dart';
import '../../models/articles/imageModel.dart';

class ArticlesRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future postArticle(ImageModel image, String uId) async {
    try {
      TaskSnapshot taskSnapshot = await _storage
          .ref()
          .child('articlesImg/${image.articleName}')
          .putFile(image.file);

      if (taskSnapshot.state == TaskState.success) {
        final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        var article = ArticleModel(
            url: downloadUrl,
            description: image.description,
            articleName: image.articleName,
            uId: uId);

        await _database
            .reference()
            .child('Article')
            .push()
            .set(article.toJson());
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
      await _database.reference().child('Article').once().then((resp) {
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

  Future getArticleByNodeValue() async {}

  Future getObtainedArticleByUid() async {}

  Future getPublishedArticleByUid() async {}

/**
    try {} on FirebaseException catch (e) {
    print(e.toString());
    } catch (e) {
    print(e.toString());
    }
 */
}
