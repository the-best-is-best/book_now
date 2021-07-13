import 'package:book_now/db/db.dart';
import 'package:book_now/modals/houses/create_house_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/modals/listen_model/create_listen_data_model.dart';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/houses_tabs/create_house_tab.dart';
import 'package:book_now/screens/tabs/houses_tabs/select_house_tab.dart';
import 'package:flutter/material.dart';
import 'package:book_now/extention/to_map.dart';

class HousesProvider with ChangeNotifier {
  List<HouseModel> myHouses = [];

  Future getHousesFromDB() async {
    List<Map<dynamic, dynamic>> data = await DB.getDataFromDB('houses');

    List.generate(data.length, (i) {
      myHouses.add(HouseModel.fromJson(data[i]));
    });
  }

  Future getHouses(List<ListenDataModel> lisenData) async {
    List<ListenDataModel> getNewHouses = [];
    getNewHouses = lisenData
        .where((val) => val.action == "inserted" && val.tableName == "houses")
        .toList();

    List<int> id = [];
    getNewHouses.forEach((val) => id.add(val.recordId));
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_houses.php', query: data);
    if (response.statusCode == 201) {
      var data = response.data;

      return toList(data['data']);
    }
  }

  Future<dynamic> toList(List<dynamic> datas) async {
    datas.forEach((data) {
      myHouses.add(HouseModel.fromJson(data));
    });
  }

  bool loading = false;

  Future createHouseClicked(CreateHouseModel createHouseModel) async {
    loading = true;
    notifyListeners();
    var createHouse = createHouseModel.toJson();
    await DB.insertToDB(tableName: 'houses', data: createHouse);

    var response = await DioHelper.postData(
      url: "insert_data/create_houses.php",
      query: createHouse,
    );

    return response;
  }

  insertToList(HouseModel data) async {
    myHouses.add(data);

    var logData = CreateListenModel(
            recordId: data.id, tableName: "houses", action: "inserted")
        .toJson();

    await DB.insertToDB(tableName: 'book_now_log', data: logData);

    loading = false;
    notifyListeners();
  }

  void insertFiled() {
    loading = false;
    notifyListeners();
  }

  Future updateFloor(int id, int floor) async {
    loading = true;
    notifyListeners();
    Map<String, int> data = {
      "id": id,
      "floor": floor,
    };
    var response = await DioHelper.putData(
      url: "update_data/floors_update.php",
      query: data,
    );
    HouseModel? houseUpdated;
    var resData = response.data;
    if (resData['messages'][0] == "Floor updated") {
      houseUpdated = myHouses.firstWhere((house) => house.id == id);
      houseUpdated.floor = int.parse(resData['data']['floor']);
    }

    loading = false;
    notifyListeners();

    return response;
  }

  bool loadingSearch = false;
  List<HouseModel> searchMyHouse = [];
  void searchHouse(String search) {
    loadingSearch = true;
    notifyListeners();
    if (search != "") {
      searchMyHouse =
          myHouses.where((house) => house.name.contains(search)).toList();
    }
    loadingSearch = false;
    notifyListeners();
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    createHouseTab(),
    selectHousesTab(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
