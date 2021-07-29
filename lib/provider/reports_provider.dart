import 'package:book_now/modals/create_project/projects_model.dart';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_people_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_select_reports_tab.dart';
import 'package:book_now/screens/tabs/report_tabs/rep_details_residence.dart';
import 'package:flutter/material.dart';
import 'package:book_now/extention/to_map.dart';

class ReportsProvider with ChangeNotifier {
  ProjectsModel? myProject;
  List<RelPeopleModel> myRelPeople = [];
  Map<int, int> numberofBedsRemaining = {};

  void getDataProject(ProjectsModel project) {
    myProject = project;
  }

  void backProject() {
    myProject = null;
    myRelPeople = [];
    numberofBedsRemaining = {};
  }

  Future getDataRelPeople(List<ListenDataModel> listenData) async {
    List<int> id = [];
    listenData.forEach((val) {
      id.add(val.recordId);
    });
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));
    data["project_id"] = myProject!.id;

    var response = await DioHelper.getData(
        url: 'rel/get_data/get_rel_people.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];
      print(response);
      // update list
      datas.forEach((data) => myRelPeople.add(RelPeopleModel.fromJson(data)));
    }
    notifyListeners();
  }

  Future getnumberofBedsRemaining() async {
    int key;
    numberofBedsRemaining = {};
    myRelPeople.forEach((val) {
      key = val.roomId;
      if (numberofBedsRemaining.containsKey(key)) {
        int? value = numberofBedsRemaining[key];
        numberofBedsRemaining[key] = value! + 1;
      } else {
        numberofBedsRemaining[key] = 1;
      }
    });
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    repManagementReportsTab(),
    repDetailsResidenceTab(),
    repSelectPeople(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }

  void getNewData() {
    notifyListeners();
  }
}
