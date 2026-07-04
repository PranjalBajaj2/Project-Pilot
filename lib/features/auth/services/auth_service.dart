import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
      );

      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(user.toMap());
    }on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try{
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }on FirebaseAuthException catch (e) {
      throw Exception(_firebaseError(e));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> forgotPassword(
      String email,
      ) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }
}

String _firebaseError(FirebaseAuthException e) {
  switch (e.code) {
    case 'email-already-in-use':
      return 'This email is already registered.';

    case 'invalid-email':
      return 'Please enter a valid email address.';

    case 'weak-password':
      return 'Password should be at least 6 characters.';

    case 'user-not-found':
      return 'No account found with this email.';

    case 'wrong-password':
      return 'Incorrect password.';

    case 'invalid-credential':
      return 'Invalid email or password.';

    case 'too-many-requests':
      return 'Too many attempts. Please try again later.';

    default:
      return e.message ?? 'Something went wrong.';
  }
}