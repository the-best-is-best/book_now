import 'dart:developer';
import 'dart:io';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GetDataListen {
  static bool getData = false;
  static void getDataServer() {
    getData = false;
  }
}

class CheckDataProvider with ChangeNotifier {
  bool loading = false;
  bool firstTime = true;

  List<ListenDataModel> listenData = [];

  List<ListenDataModel> listenDataUpdated = [];

  List<ListenDataModel> insertProject = [];

  List<ListenDataModel> insertHouses = [];
  List<ListenDataModel> updateHouses = [];

  List<ListenDataModel> insertRooms = [];
  List<ListenDataModel> updateRooms = [];

  List<ListenDataModel> insertPeople = [];
  List<ListenDataModel> updatePeople = [];

  List<ListenDataModel> insertTravel = [];
  List<ListenDataModel> updateTravel = [];

  Future<bool> getMAinListenData() async {
    if (!GetDataListen.getData) {
      Map<String, dynamic> data = {'book_now_log_count': listenData.length};
      var response = await DioHelper.postData(url: 'listenDB.php', query: data);
      if (response.data['messages'][0] == 'data changed') {
        var data = response.data;

        return await toMainList(data['data']);
      }
    }

    return false;
  }

  Future<bool> toMainList(Map datas) async {
    datas.forEach((k, data) {
      listenData.add(ListenDataModel.fromJson(data));
    });

    datas.forEach((k, data) {
      listenDataUpdated.add(ListenDataModel.fromJson(data));
    });

    insertProject = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "project")
        .toList();

    insertHouses = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "houses")
        .toList();
    if (!firstTime) {
      updateHouses = listenDataUpdated
          .where((e) => e.action == "updated" && e.tableName == "houses")
          .toList();
    }

    insertRooms = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "rooms")
        .toList();
    if (!firstTime) {
      updateRooms = listenDataUpdated
          .where((e) => e.action == "updated" && e.tableName == "rooms")
          .toList();
    }

    insertPeople = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "people")
        .toList();
    if (!firstTime) {
      updatePeople = listenDataUpdated
          .where((e) => e.action == "updated" && e.tableName == "people")
          .toList();
    }

    insertTravel = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "travel")
        .toList();
    if (!firstTime) {
      updateTravel = listenDataUpdated
          .where((e) => e.action == "updated" && e.tableName == "travel")
          .toList();
    }

    return true;
  }

  void endMainList() {
    firstTime = false;

    listenDataUpdated = [];

    insertProject = [];

    insertHouses = [];
    updateHouses = [];

    insertRooms = [];
    updateRooms = [];

    insertPeople = [];
    updatePeople = [];

    insertTravel = [];
    updateTravel = [];
  }

  Future<bool> getRelListenData({bool fromProject = false}) async {
    if (!GetDataListen.getData || fromProject) {
      Map<String, dynamic> data = {
        'book_now_rel_log_count': listenRelData.length
      };
      var response =
          await DioHelper.postData(url: 'listen_relDB.php', query: data);

      if (response.data['messages'][0] == 'data changed') {
        var data = response.data;

        return await toRelList(data['data']);
      }
    }

    return false;
  }

  List<ListenDataModel> listenRelData = [];

  List<ListenDataModel> listenRelDataUpdated = [];

  List<ListenDataModel> insertRelPeople = [];
  List<ListenDataModel> updateRelPeople = [];

  Future<bool> toRelList(Map datas) async {
    datas.forEach((k, data) {
      listenRelData.add(ListenDataModel.fromJson(data));
    });

    datas.forEach((k, data) {
      listenRelDataUpdated.add(ListenDataModel.fromJson(data));
    });

    insertRelPeople = listenRelDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "rel_people")
        .toList();

    updateRelPeople = listenRelDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "rel_people")
        .toList();

    return true;
  }

  void endedLoadDataFromServer() {
    GetDataListen.getData = true;
  }

  void endRelList() {
    listenRelDataUpdated = [];
    insertRelPeople = [];
    updateRelPeople = [];
  }

  void destroyListenProject() {
    listenRelData = [];
  }

  void displayLoading(disLoading) {
    loading = disLoading;
    notifyListeners();
  }

  int recInPage = 20;
  int maxPage = 0;

  List<ListenDataModel> history = [];

  bool loadNewHistoryData = false;
  void getMaxPage() {
    maxPage = 0;
    loadNewHistoryData = true;

    notifyListeners();
    bool decimal = false;
    if (((listenData.length) / recInPage) % 1 != 0) {
      decimal = true;
    }
    maxPage = decimal
        ? listenData.length ~/ recInPage + 1
        : listenData.length ~/ recInPage;
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
      history = [];
      curPage = 1;
    }
    loadNewHistoryData = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      history = listenData
          .getRange(0, page != maxPage ? page * recInPage : listenData.length)
          .toList();
      sleep(const Duration(seconds: 1));
      loadNewHistoryData = false;
      notifyListeners();
    });
  }

  List<ListenDataModel> filterHistoryData = [];
  bool filterd = false;
  bool filterLoading = false;
  void filterHistory(DateTime from, DateTime to) {
    filterLoading = true;
    notifyListeners();
    filterHistoryData = history.where((his) {
      return DateTime.parse(his.date).isAfter(from) &&
          DateTime.parse(his.date).isBefore(to);
    }).toList();
    filterd = true;
    filterLoading = false;
    notifyListeners();
  }

  void disableFilter() {
    filterd = false;
    notifyListeners();
  }
}
