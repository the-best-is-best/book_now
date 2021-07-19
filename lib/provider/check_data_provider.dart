// import 'package:book_now/db/db.dart';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/foundation.dart';

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

  bool getData = false;

  Future getListenData() async {
    if (!getData) {
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
      if (response.data['messages'][0] == 'data changed') {
        var data = response.data;
        getData = true;
        return await toList(data['data']);
      }
      getData = true;
    }
  }

  void listenDataChange() {
    getData = false;
  }

  Future<dynamic> toList(Map datas) async {
    datas.forEach((k, data) {
      lisenData.add(ListenDataModel.fromJson(data));
    });

    datas.forEach((k, datas) {
      lisenDataUpdated.add(ListenDataModel.fromJson(datas));
    });
    print(lisenDataUpdated.length);
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

    print("coneected");

    return true;
  }
}
