import 'package:book_now/modals/create_project/projects_model.dart';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_people_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_reports_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_travel.dart';
import 'package:flutter/material.dart';

class ReportsProvider with ChangeNotifier {
  ProjectsModel? myProject;
  RelPeopleModel? relPeopleModel;

  Future getDataProject(ProjectsModel project) async {
    myProject = project;
  }

  void backProject() {
    myProject = relPeopleModel = null;
  }

  Future getDataRelPerson(List<ListenDataModel> listenData) async {}

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    RepSelectReportsTab(),
    RepSelectTravelTab(),
    RepSelectPeople(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
