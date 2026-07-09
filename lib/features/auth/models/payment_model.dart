import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final String id;
  final String userId;

  final String clientId;
  final String? clientName;

  final String projectId;
  final String? projectName;
  final String notes;

  final double amount;

  final Timestamp paymentDate;
  final Timestamp createdAt;

  PaymentModel({
    required this.id,
    required this.userId,
    required this.clientId,
    this.clientName,
    required this.projectId,
    this.projectName,
    required this.notes,
    required this.amount,
    required this.paymentDate,
    required this.createdAt,
  });

  Map<String, dynamic> toMap(){
    return{
      "userId": userId,
      "clientId": clientId,
      "clientName": clientName,
      "projectId": projectId,
      "projectName": projectName,
      "notes": notes,
      "amount": amount,
      "paymentDate": paymentDate,
      "createdAt": createdAt
    };
  }
  factory PaymentModel.fromMap(
      String id,
      Map<String,dynamic> map,
      ){
    return PaymentModel(
        id: id,
        userId: map["userId"],
        clientId: map["clientId"],
        clientName: map["clientName"],
        projectId: map["projectId"],
        projectName: map["projectNAme"],
        notes: map["notes"],
        amount: map["amount"],
        paymentDate: map["paymentDate"],
        createdAt: map["createdAt"]
    );
  }
}
