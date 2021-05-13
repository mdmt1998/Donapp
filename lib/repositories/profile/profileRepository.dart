import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/auth/userDataModel.dart';

class ProfileRepository {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Future getUserData(String uId) async {
    try {
      var data = await _database
          .reference()
          .child('User') // node
          .orderByChild('uId') // property
          .equalTo('$uId')
          .once()
          .then((DataSnapshot snapshot) {
        final value = snapshot.value as Map;

        for (final key in value.keys) {
          return value[key];
        }
      });

      return UserData.fromJson(data);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  getNodeValueByUId(String uId) async {
    try {
      var data = await _database
          .reference()
          .child('User') // node
          .orderByChild('uId') // property
          .equalTo('$uId')
          .once()
          .then((DataSnapshot snapshot) {
        final value = snapshot.value as Map;

        return value.keys
            .toString()
            .replaceFirst('(', '')
            .replaceFirst(')', '');
      });

      return data;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateUserData(UserData data, String nodeValue) async {
    try {
      await _database
          .reference()
          .child('User')
          .child(nodeValue)
          .update(data.toJson());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
