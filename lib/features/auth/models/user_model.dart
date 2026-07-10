import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;
  final Timestamp createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.photoUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "photoUrl": photoUrl,
      "createdAt": createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map["uid"],
      name: map["name"],
      email: map["email"],
      phone: map["phone"] ?? "",
      photoUrl: map["photoUrl"] ?? "",
      createdAt: map["createdAt"] ?? Timestamp.now(),
    );
  }
}
