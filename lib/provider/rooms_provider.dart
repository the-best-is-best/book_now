import 'package:book_now/modals/lisen_data_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:book_now/extention/to_map.dart';

class RoomsProvider with ChangeNotifier {
  List<RoomsModel> myRoomes = [];

  Future getRooms(List<LisenDataModel> lisenData) async {
    List<LisenDataModel> getNewRooms = [];
    getNewRooms = lisenData
        .where((val) => val.action == "inserted" && val.tableName == "rooms")
        .toList();

    List<int> id = [];
    getNewRooms.forEach((val) => id.add(val.recordId));
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_rooms.php', query: data);
    if (response.statusCode == 201) {
      var data = response.data;
      return toList(data['data']);
    }
  }

  Future<dynamic> toList(List<dynamic> datas) async {
    myRoomes = [];
    datas.forEach((data) {
      myRoomes.add(RoomsModel.fromJson(data));
    });
    return myRoomes;
  }
}
