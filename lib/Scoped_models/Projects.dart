import 'package:scoped_model/scoped_model.dart';
import '../Classes/Project.dart';
import '../Classes/Student.dart';

class ProjectsModel extends Model {
  List<Project> all_projects = [];

  void add_project(Project project) {
    all_projects.add(project);
  }

  void add_member(Project, Student) {}
}
