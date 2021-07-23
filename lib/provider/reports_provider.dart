import 'package:book_now/screens/tabs/report_tabs/rep_select_people_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_reports_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_travel.dart';
import 'package:flutter/material.dart';

class ReportsProvider with ChangeNotifier {
  int myProject = 0;

  Future goToProject(int project) async {
    myProject = project;
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    RepSelectReportsTab(),
    RepSelectPeople(),
    RepSelectTravelTab(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
