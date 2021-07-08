import 'package:book_now/modals/houses/create_house_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/create_select_tab/select_project.dart';
import 'package:book_now/screens/tabs/houses_tabs/create_house_tab.dart';
import 'package:flutter/material.dart';

class HousesProvider with ChangeNotifier {
  List<HouseModel> myHouses = [];

  Future getHouses() async {
    if (myHouses.length == 0) {
      Map<String, dynamic> data = {};
      var response =
          await DioHelper.getData(url: 'get_data/get_houses.php', query: data);
      if (response.statusCode == 201) {
        var data = response.data;
        return toList(data['data']);
      }
    }
  }

  Future<dynamic> toList(List<dynamic> datas) async {
    myHouses = [];
    datas.forEach((data) {
      myHouses.add(HouseModel.fromJson(data));
    });
    return myHouses;
  }

  bool loading = false;

  Future createProjectClicked(CreateHouseModel createHouseModel) async {
    loading = true;
    notifyListeners();
    var createProject = createHouseModel.toJson();
    print(createProject);
    var response = await DioHelper.postData(
      url: "insert_data/create_houses.php.php",
      query: createProject,
    );
    return response;
  }

  void insertToList(HouseModel data) {
    myHouses.add(data);
    loading = false;
    notifyListeners();
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    createHouseTab(),
    selectProjectTab(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
