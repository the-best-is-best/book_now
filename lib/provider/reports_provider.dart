import 'dart:io';

import 'package:book_now/modals/create_project/projects_model.dart';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
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

  Future getDataRelPeople(
      List<ListenDataModel> listenData, List<RoomsModel> myRoom) async {
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
      // update list
      datas.forEach((data) {
        data['floor'] = myRoom
            .firstWhere((room) =>
                room.id == data['room_id'] && room.houseId == data['house_id'])
            .floor;
        myRelPeople.add(RelPeopleModel.fromJson(data));
      });
    }
    notifyListeners();
  }

  Future getUpdateDataRelPeople(
      List<ListenDataModel> listenData, List<RoomsModel> myRoom) async {
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
      // update list
      datas.forEach((data) {
        data['floor'] = myRoom
            .firstWhere((room) =>
                room.id == data['room_id'] && room.houseId == data['house_id'])
            .floor;
        RelPeopleModel getRelPeopleData = myRelPeople.firstWhere((people) =>
            people.id == data['people_id'] &&
            people.projectId == data['project_id']);

        getRelPeopleData.roomId = data['room_id'];
        getRelPeopleData.floor = data['floor'];
        getRelPeopleData.paid = data['paid'];
        getRelPeopleData.support = data['support'];
        getRelPeopleData.bones = data['coupons'] == 1 ? true : false;
        getRelPeopleData.travelId = data['travel_id'];
      });
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
    notifyListeners();
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

  int recInPage = 20;
  int maxPage = 0;

  List<RelPeopleModel> relPeopleData = [];

  bool loadNewRelPeopleData = false;
  void getMaxPage() {
    maxPage = 0;
    loadNewRelPeopleData = true;

    notifyListeners();
    bool decimal = false;
    if (((myRelPeople.length) / recInPage) % 1 != 0) {
      decimal = true;
    }
    maxPage = decimal
        ? myRelPeople.length ~/ recInPage + 1
        : myRelPeople.length ~/ recInPage;
  }

  int curPage = 1;
  Future getNexPage() async {
    if (maxPage != 0) {
      if (curPage != maxPage) {
        curPage += 1;
        await getDataPage(curPage);
      } else {
        curPage = curPage;
      }
    }
  }

  Future getDataPage(int page) async {
    if (page == 1) {
      relPeopleData = [];
      curPage = 1;
    }
    loadNewRelPeopleData = true;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 500), () {
      relPeopleData = myRelPeople
          .getRange(0, page != maxPage ? page * recInPage : myRelPeople.length)
          .toList();
      sleep(const Duration(seconds: 1));
      loadNewRelPeopleData = false;
      notifyListeners();
    });
  }

  List<RelPeopleModel> searchRelPeople = [];
  bool loadingSearch = false;
  bool searched = false;
  void searchInRelPeople(String search) {
    loadingSearch = true;
    if (search != "") {
      searchRelPeople = myRelPeople
          .where((people) => people.peopleName.contains(search))
          .toList();
      searched = true;
    } else {
      searchRelPeople = [];
      searched = false;
    }

    loadingSearch = false;
    notifyListeners();
  }
}
