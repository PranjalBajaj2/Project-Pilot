import 'package:cloud_firestore/cloud_firestore.dart';

class ClientModel {
  final String id;
  final String userId;
  final String? name;
  final String? company;
  final String? email;
  final String? phone;
  final String? address;
  final String? project;
  final String? notes;
  final Timestamp createdAt;

  const ClientModel({
    required this.id,
    required this.userId,
    required this.name,
     this.company,
     this.email,
     this.phone,
     this.address,
     this.notes,
    required this.createdAt,
    required this.project
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'company': company,
      'email': email,
      'phone': phone,
      'address': address,
      'notes': notes,
      'project': project,
      'createdAt': createdAt,
    };
  }

  factory ClientModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ClientModel(
      id: doc.id,
      userId: data['userId'],
      name: data['name'],
      company: data['company'],
      email: data['email'],
      phone: data['phone'],
      address: data['address'],
      notes: data['notes'],
      project: data['project'],
      createdAt: data['createdAt'],
    );
  }
    factory ClientModel.fromMap(String id, Map<String, dynamic> map) {
      return ClientModel(
        id: id,
        userId: map['userId'],
        name: map['name'],
        company: map['company'],
        email: map['email'],
        phone: map['phone'],
        address: map['address'],
        notes: map['notes'],
        project: map['project'],
        createdAt: map['createdAt'],
      );
    }
  }