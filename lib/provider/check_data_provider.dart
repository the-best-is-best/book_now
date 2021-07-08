import 'package:book_now/modals/lisen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/foundation.dart';

class CheckDataProvider with ChangeNotifier {
  List<LisenDataModel> lisenData = [];

  Future getLisenData() async {
    Map<String, dynamic> data = {'book_now_log_count': 0};
    var response = await DioHelper.postData(url: 'lisenDB.php', query: data);
    print(response.toString());
    if (response.statusCode == 201) {
      var data = response.data;
      return toList(data['data']);
    }
  }

  Future<dynamic> toList(Map datas) async {
    lisenData = [];

    datas.forEach((k, data) {
      lisenData.add(LisenDataModel.fromJson(data));
    });
    return lisenData;
  }

  Future getNewData() async {
    List<LisenDataModel> getNewHouses = [];

    getNewHouses = lisenData
        .where((val) => val.action == "inserted" && val.tableName == "houses")
        .toList();

    List<int> id = [];
    getNewHouses.forEach((val) => id.add(val.recordId));
    Map<String, dynamic> data = {};
    data = Map.fromIterable(id, key: (e) => e.toString(), value: (e) => e);

    var response = await DioHelper.postData(url: 'lisenDB.php', query: data);
    print(response.toString());
    if (response.statusCode == 201) {
      var data = response.data;
      return data['data'];
    }
  }
}
