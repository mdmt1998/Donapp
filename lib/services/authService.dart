import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // // create user obj based on firebase User
  // UserModel _userFromFirebaseUser(User firebaseUser) {
  //   return firebaseUser != null ? UserModel(uId: firebaseUser.uid) : null;
  // }

  // Stream<UserModel> get user {
  //   return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  // }

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

  Future userData(String uId, String email, String password, String name,
      String address, int phoneNumber, String city) async {
    try {
      var data = {
        'uId': uId,
        'email': email, //
        'password': password, //
        'name': name,
        'address': address,
        'phoneNumber': phoneNumber,
        'city': city
      };

      await _database.reference().child('User').push().set(data);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  Future register(String email, String password) async {
    try {
      var user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      //     _database. .database().ref('users/' + user.uid).set({
      //     firstName: firstName,
      //     lastName: lastNames
      // })

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
