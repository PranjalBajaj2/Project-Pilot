import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/project_model.dart';

class ProjectService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference get _projectCollection =>
      firestore.collection("projects");

  Future<void> addProject(ProjectModel project) async {
    try {
      await _projectCollection.add(project.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProjectModel>> getProjects() {
    return _projectCollection
        .where(
      "userId",
      isEqualTo: auth.currentUser!.uid,
    ).snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProjectModel.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  Future<void> updateProject(ProjectModel project) async {
    try {
      await _projectCollection
          .doc(project.id)
          .update(project.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProject(String id) async {
    try {
      await _projectCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}