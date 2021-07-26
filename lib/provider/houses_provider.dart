import 'package:book_now/modals/houses/create_house_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/houses_tabs/create_house_tab.dart';
import 'package:book_now/screens/tabs/houses_tabs/select_house_tab.dart';
import 'package:flutter/material.dart';
import 'package:book_now/extention/to_map.dart';

class HousesProvider with ChangeNotifier {
  List<HouseModel> myHouses = [];

//get data server
  Future getHouses(List<ListenDataModel> listenData) async {
// convert data to json
    List<int> id = [];
    listenData.forEach((val) {
      id.add(val.recordId);
    });
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_houses.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];

      // update list
      datas.forEach((data) => myHouses.add(HouseModel.fromJson(data)));
    }
    notifyListeners();
  }

  Future getUpdateHouses(List<ListenDataModel> listenData) async {
    List<int> id = [];

    listenData.forEach((val) => id.add(val.recordId));
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_houses.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];
      HouseModel? houseUpdated;
      datas.forEach((data) async {
        houseUpdated = myHouses.firstWhere(
            (house) => house.id == int.parse(data['id'].toString()),
            orElse: () => HouseModel(id: 0, name: "", floor: 0));
        if (houseUpdated!.id != 0) {
          houseUpdated!.floor = int.parse(data['floor'].toString());
        }
      });
    }
    notifyListeners();
  }

  bool loading = false;

  Future createHouseClicked(CreateHouseModel createHouseModel) async {
    loading = true;
    notifyListeners();
    var createHouse = createHouseModel.toJson();
    var response = await DioHelper.postData(
      url: "insert_data/create_houses.php",
      query: createHouse,
    );

    notifyListeners();

    return response;
  }

  Future loadingEnd() async {
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
