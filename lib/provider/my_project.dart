import 'package:book_now/modals/projects_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/create_project_tab.dart';
import 'package:book_now/screens/tabs/select_project.dart';
import 'package:flutter/material.dart';

class MyProjectProvider with ChangeNotifier {
  List<ProjectsModel> myProject = [];

  Future getData() async {
    if (myProject.length == 0) {
      Map<String, dynamic> data = {};
      var response = await DioHelper.getData(
          url: 'get_data/get_projects.php', query: data);
      if (response.statusCode == 201) {
        var data = response.data;
        toList(data['data']);
      }
      return "error";
    }
  }

  void toList(List<dynamic> datas) {
    myProject = [];
    datas.forEach((v) {
      myProject.add(new ProjectsModel(
          id: v['id'],
          projectName: v['project_name'],
          endDate: DateTime.parse(v['end_date'])));
    });
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
