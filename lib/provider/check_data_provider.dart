import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/foundation.dart';

class GetDataListen {
  static bool getData = false;
  static void getDataServer() {
    getData = false;
  }
}

class CheckDataProvider with ChangeNotifier {
  List<ListenDataModel> lisenData = [];

  List<ListenDataModel> lisenDataUpdated = [];

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
      lisenDataUpdated = [];

      insertProject = [];

      insertHouses = [];
      updateHouses = [];

      insertRooms = [];
      updateRooms = [];

      insertPeople = [];
      updatePeople = [];

      insertTravel = [];
      updateTravel = [];

      Map<String, dynamic> data = {'book_now_log_count': lisenData.length};
      var response = await DioHelper.postData(url: 'listenDB.php', query: data);
      bool newData = false;
      if (response.data['messages'][0] == 'data changed') {
        var data = response.data;
        GetDataListen.getData = true;
        newData = await toMainList(data['data']);
      }
      GetDataListen.getData = true;
      return newData;
    }
    return false;
  }

  Future<bool> toMainList(Map datas) async {
    datas.forEach((k, data) {
      lisenData.add(ListenDataModel.fromJson(data));
    });

    datas.forEach((k, data) {
      lisenDataUpdated.add(ListenDataModel.fromJson(data));
    });

    insertProject = lisenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "project")
        .toList();

    insertHouses = lisenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "houses")
        .toList();

    updateHouses = lisenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "houses")
        .toList();

    insertRooms = lisenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "rooms")
        .toList();

    updateRooms = lisenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "rooms")
        .toList();

    insertPeople = lisenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "people")
        .toList();

    updatePeople = lisenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "people")
        .toList();

    insertTravel = lisenDataUpdated
        .where((e) => e.action == "inserted" && e.tableName == "travel")
        .toList();

    updateTravel = lisenDataUpdated
        .where((e) => e.action == "updated" && e.tableName == "travel")
        .toList();

    return true;
  }

  void endMainList() {
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

  Future<bool> getRelListenData() async {
    if (!GetDataListen.getData) {
      lisenDataUpdated = [];
      insertRelPeople = [];

      Map<String, dynamic> data = {
        'book_now_rel_log_count': lisenRelData.length
      };
      var response =
          await DioHelper.postData(url: 'listen_rel_DB.php', query: data);
      bool newData = false;
      if (response.data['messages'][0] == 'data changed') {
        var data = response.data;
        GetDataListen.getData = true;
        newData = await toRelList(data['data']);
      }
      GetDataListen.getData = true;
      return newData;
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
        .where((e) => e.action == "inserted" && e.tableName == "rel_project")
        .toList();

    return true;
  }

  void endRelList() {
    lisenDataUpdated = [];
    insertRelPeople = [];
  }
}
