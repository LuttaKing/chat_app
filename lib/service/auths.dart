import 'package:chat_app/components/constants.dart';
import 'package:chat_app/service/notif.dart';
import 'package:chat_app/pages/homepage.dart';
import 'package:chat_app/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  //instance of firestore
  final _firestore = FirebaseFirestore.instance;

  Future createAccountwEmailandPass(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((UserCredential value) {
//after creating user, create a new document for the user in users collection
        _firestore
            .collection('users')
            .doc(value.user!.uid)
            .set({'uid': value.user!.uid, 'email': value.user!.email});

        goToPage(context, const LoginPage());
        showSnackx(context, 'Success');
      });
      //  _auth.currentUser!.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      showSnackx(context, e.code);
    }
  }

  Future signinwEmailandPass(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential value) {
Provider.of<MainNotifier>(context, listen: false).changeuid(value.user!.uid);
             Provider.of<MainNotifier>(context, listen: false).changeEmailr(value.user!.email);
        // create a new document if it dont exist
        _firestore.collection('users').doc(value.user!.uid).set(
            {'uid': value.user!.uid, 'email': value.user!.email},
            SetOptions(merge: true));
        showSnackx(context, 'Success');
        goToPage(context, const HomePage());
      });
    } on FirebaseAuthException catch (e) {
      showSnackx(context, e.code);
    }
  }

  Future<void> signOut(BuildContext context) async {
    _auth.signOut();

    goToPage(context, const LoginPage());
  }

  String? curentUser() {
    debugPrint(_auth.currentUser!.email);
    return _auth.currentUser!.email;
  }
}
