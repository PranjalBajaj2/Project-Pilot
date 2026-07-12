import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class ProfileService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserModel> getProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await firestore.collection("users").doc(uid).get();

    return UserModel.fromMap(doc.data()!);
  }

  Future<void> updateProfile(UserModel user) async {
    await firestore.collection("users").doc(user.uid).update(user.toMap());
  }
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = FirebaseAuth.instance.currentUser!;

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(
      credential,
    );

    await user.updatePassword(newPassword);
  }
}
