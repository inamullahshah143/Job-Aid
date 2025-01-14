import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:job_aid/constants/components.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN UP METHOD
  Future signUp({String? email, String? password}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  //SIGN IN METHOD
  Future signIn({String? email, String? password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      return result;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  // SIGN IN With Google
  Future<User> signInWithGoogle({BuildContext? context}) async {
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      user = userCredential.user!;
    } on FirebaseAuthException catch (e) {
      Components.showSnackBar(context!, e.message!);
    }
    return user!;
  }

  Future signOut({BuildContext? context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context!).pop();
      Components.showSnackBar(context, e.message!);
    }
  }

  Future resetPassword(context, String email) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        return value;
      });
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future changePassword(context, newPassword) async {
    try {
      await FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      Components.showSnackBar(context, e.message!);
    }
  }
}
