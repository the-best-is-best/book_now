import 'package:book_now/modals/lisen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/foundation.dart';

class CheckDataProvider with ChangeNotifier {
  List<LisenDataModel> lisenData = [];
  List<LisenDataModel> insertHouses = [];

  Future getLisenData() async {
    if (lisenData.length == 0) {
      Map<String, dynamic> data = {'book_now_log_count': 0};
      var response = await DioHelper.postData(url: 'lisenDB.php', query: data);
      print(response.toString());
      if (response.data['messages'][0] == 'data changed') {
        var data = response.data;
        toList(data['data']);
      }
    }
  }

  Future<dynamic> toList(Map datas) async {
    lisenData = [];

    datas.forEach((k, data) {
      lisenData.add(LisenDataModel.fromJson(data));
    });
    insertHouses = lisenData
        .where((e) => e.action == "inserted" && e.tableName == "houses")
        .toList();
  }
}
