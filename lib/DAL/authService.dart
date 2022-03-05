
import 'package:CovidTracker/DAL/user.dart';
import 'package:CovidTracker/DAL/utilisateur.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create user obj based on firebase user
  utilisateur? _userFromFirebaseUser(User user) {
    return user != null ? utilisateur(uid: user.uid) : null;
  }


  Future<void> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
    }
    catch (e) {
      print(e.toString());
    }
  }

  //auth change user stream
  Stream<utilisateur?> get user {
    return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user!));
  }

// sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      //create new document for user
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPassword(String email) async {
    try {await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);

      return 8;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}