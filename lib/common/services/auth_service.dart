import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/auth/user_model.dart';
import '../../model/medicine/add_medicine_model.dart';
import '../constant/firebase_string.dart';
import '../constant/path_string.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Auth Service Sign Up
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = userCredential.user!.uid;
      UserModel userModel =
          UserModel(uid: uid, username: name, email: email, password: password);

      await _firestore
          .collection(FirebaseString.usersCollection)
          .doc(uid)
          .set(userModel.toJson());
    } catch (e) {
      rethrow;
    }
  }

  /// Auth Service Login
  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacementNamed(context, PathString.homeScreen);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Failed: ${e.toString()}")),
      );
    }
  }

  /// Auth Service Logout
  Future<void> logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, PathString.loginScreen);
  }

  // Uploading Medicine
  Future<void> uploadMedicalReport(AddMedicineModel medicineJson) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _firestore
          .collection(PathString.homeScreen)
          .doc(user.uid)
          .collection(FirebaseString.usersCollection)
          .add(medicineJson.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
