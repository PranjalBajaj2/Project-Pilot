import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectpilot/features/auth/project_enums.dart';

class ProjectModel {
  final String id;
  final String userId;

  final String clientId;
  final String? clientName;

  final String projectName;
  final String description;

  final double budget;
  final String currency;

  final String status;


  final Timestamp startDate;
  final Timestamp deadline;

  final Timestamp createdAt;

  ProjectModel({
    required this.id,
    required this.userId,
    required this.clientId,
    required this.clientName,
    required this.projectName,
    required this.description,
    required this.budget,
    required this.currency,
    required this.status,
    required this.startDate,
    required this.deadline,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "clientId": clientId,
      "clientName": clientName,
      "projectName": projectName,
      "description": description,
      "budget": budget,
      "currency": currency,
      "status": status,
      "startDate": startDate,
      "deadline": deadline,
      "createdAt": createdAt,
    };
  }

  factory ProjectModel.fromMap(
      String id,
      Map<String, dynamic> map,
      ) {
    return ProjectModel(
      id: id,
      userId: map["userId"],
      clientId: map["clientId"],
      clientName: map["clientName"],
      projectName: map["projectName"],
      description: map["description"],
      budget: (map["budget"] as num).toDouble(),
      currency: map["currency"],
      status: map["status"],
      startDate: map["startDate"],
      deadline: map["deadline"],
      createdAt: map["createdAt"],
    );
  }
}
extension ProjectStatusExtension on ProjectStatus {

  String get label {

    switch(this){

      case ProjectStatus.pending:
        return "Pending";

      case ProjectStatus.inProgress:
        return "In Progress";

      case ProjectStatus.completed:
        return "Completed";

      case ProjectStatus.cancelled:
        return "Cancelled";

    }

  }

}