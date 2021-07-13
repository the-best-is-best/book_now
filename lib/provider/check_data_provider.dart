import 'package:book_now/db/db.dart';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/foundation.dart';

class CheckDataProvider with ChangeNotifier {
  List<ListenDataModel> lisenData = [];
  List<ListenDataModel> insertHouses = [];
  List<ListenDataModel> insertRooms = [];
  List<ListenDataModel> insertPeople = [];

  Future getCheckDataFromDB() async {
    List<Map<dynamic, dynamic>> data = await DB.getDataFromDB('book_now_log');

    List.generate(data.length, (i) {
      lisenData.add(ListenDataModel.fromJson(data[i]));
    });
  }

  Future getListenData(int bookNowLogCount) async {
    Map<String, dynamic> data = {'book_now_log_count': bookNowLogCount};
    var response = await DioHelper.postData(url: 'listenDB.php', query: data);
    if (response.data['messages'][0] == 'data changed') {
      var data = response.data;
      toList(data['data']);
    }
  }

  Future<dynamic> toList(Map datas) async {
    lisenData = [];

    datas.forEach((k, data) {
      lisenData.add(ListenDataModel.fromJson(data));
    });
    insertHouses = lisenData
        .where((e) => e.action == "inserted" && e.tableName == "houses")
        .toList();

    insertRooms = lisenData
        .where((e) => e.action == "inserted" && e.tableName == "rooms")
        .toList();

    insertPeople = lisenData
        .where((e) => e.action == "inserted" && e.tableName == "people")
        .toList();
  }
}

Future listenDBChanged() async {
  Map<String, dynamic> data = {'book_now_log_count': 0};
  var response =
      await DioHelper.postData(url: 'listenDBDelay.php', query: data);
  if (response.data['messages'][0] == 'data changed') {
    return response.data['data']['book_now_log_count'];
  }
}
