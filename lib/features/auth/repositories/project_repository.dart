import '../models/project_model.dart';
import '../services/project_services.dart';

class ProjectRepository {
  final ProjectService _service = ProjectService();

  Future<void> addProject(ProjectModel project) {
    return _service.addProject(project);
  }

  Stream<List<ProjectModel>> getProjects() {
    return _service.getProjects();
  }

  Future<void> updateProject(ProjectModel project) {
    return _service.updateProject(project);
  }

  Future<void> deleteProject(String id) {
    return _service.deleteProject(id);
  }
}
