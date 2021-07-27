import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'floor_provider.dart';
import 'houses_provider.dart';
import 'my_project_provider.dart';

class GetDataListen {
  static bool getData = false;
  static void getDataServer() {
    getData = false;
  }
}

class CheckDataProvider with ChangeNotifier {
  bool loading = false;

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

  List<ListenDataModel> lisenRelData = [];

  List<ListenDataModel> lisenRelDataUpdated = [];

  List<ListenDataModel> insertRelPeople = [];

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

    updateHouses = listenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "houses")
        .toList();

    insertRooms = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "rooms")
        .toList();

    updateRooms = listenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "rooms")
        .toList();

    insertPeople = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "people")
        .toList();

    updatePeople = listenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "people")
        .toList();

    insertTravel = listenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "travel")
        .toList();

    updateTravel = listenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "travel")
        .toList();

    return true;
  }

  void endMainList() {
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
        'book_now_rel_log_count': lisenRelData.length
      };
      var response =
          await DioHelper.postData(url: 'listen_relDB.php', query: data);

      if (response.data['messages'][0] == 'data changed') {
        var data = response.data;
        print(data['data']);
        return await toRelList(data['data']);
      }
    }
    return false;
  }

  Future<bool> toRelList(Map datas) async {
    datas.forEach((k, data) {
      lisenRelData.add(ListenDataModel.fromJson(data));
    });

    datas.forEach((k, data) {
      lisenRelDataUpdated.add(ListenDataModel.fromJson(data));
    });

    insertRelPeople = lisenRelDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "rel_people")
        .toList();
    print("new rel - people list ${insertRelPeople.length}");
    return true;
  }

  void endedLoadDataFromServer() {
    GetDataListen.getData = true;
  }

  void endRelList() {
    lisenRelDataUpdated = [];
    insertRelPeople = [];
  }

  void displayLoading(disLoading) {
    loading = disLoading;
    notifyListeners();
  }
}
