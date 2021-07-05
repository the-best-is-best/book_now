import 'package:book_now/modals/create_project/create_project_model.dart';
import 'package:book_now/modals/create_project/projects_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/create_select_tab/create_project_tab.dart';
import 'package:book_now/screens/tabs/create_select_tab/select_project.dart';
import 'package:flutter/material.dart';

class MyProjectProvider with ChangeNotifier {
  List<ProjectsModel> myProject = [];

  Future<dynamic> getData() async {
    if (myProject.length == 0) {
      Map<String, dynamic> data = {};
      var response = await DioHelper.getData(
          url: 'get_data/get_projects.php', query: data);
      if (response.statusCode == 201) {
        var data = response.data;
        return toList(data['data']);
      }
    }
  }

  Future<dynamic> toList(List<dynamic> datas) async {
    myProject = [];
    int? projectId;
    datas.forEach((data) {
      myProject.add(ProjectsModel.fromJson(data));
    });
    myProject.forEach((data) {
      if (data.endDate.isAfter(DateTime.now())) {
        projectId = data.id;
      }
    });
    if (projectId != null) {
      return projectId;
    } else {
      return null;
    }
  }

  bool loading = false;

  Future createProjectClicked(CreateProjectModel crateProjectsModel) async {
    loading = true;
    notifyListeners();
    var createProject = crateProjectsModel.toJson();
    print(createProject);
    var response = await DioHelper.postData(
      url: "insert_data/create_project.php",
      query: createProject,
    );
    return response;
  }

  void insertToList(ProjectsModel data) {
    myProject.add(data);
    loading = false;
    notifyListeners();
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    createProjectTab(),
    selectProjectTab(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
