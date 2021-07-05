import 'package:book_now/modals/create_project/projects_model.dart';
import 'package:flutter/foundation.dart';

class ReportsProvider with ChangeNotifier {
  ProjectsModel? myProject;

  void getDataProject() {}
  void goToProject(ProjectsModel project) {
    myProject = project;
  }
}
