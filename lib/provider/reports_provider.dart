import 'package:book_now/screens/tabs/report_tabs/rep_select_house_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_people_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_reports_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_travel.dart';
import 'package:flutter/material.dart';

class ReportsProvider with ChangeNotifier {
  late int myProject;

  void goToProject(int project) {
    myProject = project;
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    RepSelectReportsTab(),
    RepSelectHouseTab(),
    RepSelectPeople(),
    RepSelectTravelTab(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
