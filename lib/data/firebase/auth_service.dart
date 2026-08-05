import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/user_model.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  /// User hiện tại
  User? get currentFirebaseUser => _auth.currentUser;

  /// Lắng nghe trạng thái đăng nhập
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserModel> register({
    required String email,
    required String password,
    required String fullName,

  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    final firebaseUser = credential.user!;

    final userModel = UserModel(
      uid: firebaseUser.uid,
      email: email,
      fullName: fullName,
      role: 'user',

      isActive: true,
    );

    await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .set(userModel.toMap());
    return userModel;
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      final snapshot = await _firestore
          .collection('users')
          .doc(credential.user!.uid)
          .get();

      if (!snapshot.exists) {
        return null;
      }

      return UserModel.fromDocument(snapshot);

    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }


  Future<void> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String address,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User chưa đăng nhập");
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .update({
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }


  /// Đăng xuất
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint("Google logout: $e");
    }

    try {
      await FacebookAuth.instance.logOut();
    } catch (e) {
      debugPrint("Facebook logout: $e");
    }

    await _auth.signOut();
  }

  /// Quên mật khẩu
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email.trim(),
    );
  }

  Future<UserModel?> getCurrentUser() async {
    final firebaseUser = _auth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    final snapshot = await _firestore
        .collection('users')
        .doc(firebaseUser.uid)
        .get();

    if (!snapshot.exists) {
      return null;
    }

    return UserModel.fromDocument(snapshot);
  }

  Future<UserModel?> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser =
    await _googleSignIn.signIn();

    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
    await _auth.signInWithCredential(credential);

    final firebaseUser = userCredential.user;

    if (firebaseUser == null) {
      return null;
    }

    final docRef = _firestore
        .collection('users')
        .doc(firebaseUser.uid);

    final snapshot = await docRef.get();

    if (!snapshot.exists) {
      final user = UserModel(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        fullName: firebaseUser.displayName ?? '',
        photoUrl: firebaseUser.photoURL,
        phoneNumber: firebaseUser.phoneNumber,
        role: 'user',
        isActive: true,
        createdAt: Timestamp.now(),
      );

      await docRef.set(user.toMap());

      return user;
    }



    return UserModel.fromDocument(snapshot);
  }

  Future<UserModel?> loginWithFacebook() async {

  }
}

