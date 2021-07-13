import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/modals/people/create_people_model.dart';
import 'package:book_now/modals/people/people_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/extention/to_map.dart';
import 'package:book_now/screens/tabs/people_tab/create_people_tab.dart';
import 'package:book_now/screens/tabs/people_tab/select_people_tab.dart';
import 'package:flutter/material.dart';

class PeopleProvider with ChangeNotifier {
  List<PeopleModel> myPeople = [];

  Future getPeople(List<ListenDataModel> lisenData) async {
    List<ListenDataModel> getNewHouses = [];
    getNewHouses = lisenData
        .where((val) => val.action == "inserted" && val.tableName == "people")
        .toList();

    List<int> id = [];
    getNewHouses.forEach((val) => id.add(val.recordId));
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_people.php', query: data);
    if (response.statusCode == 201) {
      var data = response.data;

      return toList(data['data']);
    }
  }

  Future<dynamic> toList(List<dynamic> datas) async {
    myPeople = [];
    datas.forEach((data) {
      myPeople.add(PeopleModel.fromJson(data));
    });
    return myPeople;
  }

  bool loading = false;

  Future createPeopleClicked(CreatePeopleModel createPeopleModel) async {
    loading = true;
    notifyListeners();
    var createHouse = createPeopleModel.toJson();

    var response = await DioHelper.postData(
      url: "insert_data/create_people.php",
      query: createHouse,
    );

    return response;
  }

  insertToList(PeopleModel data) {
    myPeople.add(data);
    loading = false;
    notifyListeners();
  }

  void insertFiled() {
    loading = false;
    notifyListeners();
  }

  Future updatePeople(
      {required int id,
      required String name,
      required int tel,
      required String city}) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> data = {
      "id": id,
      "name": name,
      "tel": tel,
      "city": city
    };
    var response = await DioHelper.putData(
      url: "update_data/people_update.php",
      query: data,
    );
    PeopleModel? peopleUpdated;
    var resData = response.data;
    if (resData['messages'][0] == "People updated") {
      peopleUpdated = myPeople.firstWhere((people) => people.id == id);
      peopleUpdated.name = resData['data']['name'];
      peopleUpdated.tel = int.parse(resData['data']['tel']);
      peopleUpdated.city = resData['data']['city'];
    }
    loading = false;
    notifyListeners();

    return response;
  }

  bool loadingSearch = false;
  List<PeopleModel> searchMypeople = [];
  void searchHouse(String search) {
    loadingSearch = true;
    notifyListeners();
    if (search != "") {
      searchMypeople =
          myPeople.where((people) => people.name.contains(search)).toList();
    }
    loadingSearch = false;
    notifyListeners();
  }

  bool editRoomActive = false;
  void inEdit() {
    editRoomActive = !editRoomActive;
    notifyListeners();
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    createPeopleTab(),
    selectPeopleTab(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
