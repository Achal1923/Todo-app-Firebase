import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:my_todolistapp_firebase/Model/UserModel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {

  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    return user == null ? null : User(user.uid,user.email);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInWithEmailAndPassword(String email,
      String password,) async {
    try{
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password);

      return _userFromFirebase(credential.user);

    }
    catch(error)
    {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade800,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(String email,
      String password,) async {
    try{
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

      // final currentUser = credential.user;
      // DatabaseService.getCurrentUser();

      return _userFromFirebase(credential.user);
    }
    catch(error)
    {
      Fluttertoast.showToast(
          msg: error.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade800,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}