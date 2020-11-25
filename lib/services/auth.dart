import 'package:donapp/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // create user obj based on firebase User
  UserModel _userFromFirebaseUser(User firebaseUser) {
    return firebaseUser != null ? UserModel(uId: firebaseUser.uid) : null;
  }

  // sign
  // Future sign() async {
  //   try {
  //     var result = await _firebaseAuth.signInAnonymously();
  //     var user = result.user;

  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());

  //     return null;
  //   }
  // }

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signIn(String email, String password) async {
    try {
      var user = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      print('${user.additionalUserInfo}');
      return user.user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future register(String email, String password) async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: "barry.allen@example.com",
      //         password: "SuperSecretPassword!");

      var user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      print('Registered ${user.user}');
      return user.user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future currentUser() async {
    User user = _firebaseAuth.currentUser;
    return user.uid;
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future userProfile() async {
    // var user = _firebaseAuth.currentUser;

    // user.displayName;

    // var task = <String, dynamic>{
    //   'content': value,
    //   'timestamp': DateTime.now().millisecondsSinceEpoch
    // };
    // Database.addTask(task);
  }
}
