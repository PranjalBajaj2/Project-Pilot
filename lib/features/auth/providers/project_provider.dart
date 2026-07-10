import 'dart:async';

import 'package:flutter/material.dart';

import '../models/project_model.dart';
import '../repositories/project_repository.dart';

class ProjectProvider extends ChangeNotifier {
  final ProjectRepository _repository = ProjectRepository();

  List<ProjectModel> _projects = [];

  List<ProjectModel> _filteredProjects = [];

  bool isLoading = false;

  String search = "";

  String? error;

  StreamSubscription? _subscription;

  List<ProjectModel> get projects => _filteredProjects;

  void listenProjects() {
    isLoading = true;

    notifyListeners();

    _subscription?.cancel();

    _subscription = _repository.getProjects().listen(
      (event) {
        _projects = event;
        _filteredProjects = event;

        isLoading = false;

        notifyListeners();
      },
      onError: (e) {
        error = e.toString();
        isLoading = false;
        notifyListeners();
      },
    );
  }

  void searchProject(String value) {
    if (value.isEmpty) {
      _filteredProjects = _projects;
    } else {
      _filteredProjects = _projects.where((project) {
        return project.projectName!.toLowerCase().contains(
              value.toLowerCase(),
            ) ||
            project.clientName!.toLowerCase().contains(value.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }

  Future<void> addProject(ProjectModel project) async {
    await _repository.addProject(project);
  }

  Future<void> updateProject(ProjectModel project) async {
    await _repository.updateProject(project);
  }

  Future<void> deleteProject(String id) async {
    await _repository.deleteProject(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
