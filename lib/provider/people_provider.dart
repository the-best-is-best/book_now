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
    List<int> id = [];
    lisenData.forEach((val) => id.add(val.recordId));
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_people.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];

      datas.forEach((data) {
        myPeople.add(PeopleModel.fromJson(data));
      });
    }
  }

  Future getUpdatePeople(List<ListenDataModel> lisenData) async {
    List<int> id = [];

    lisenData.forEach((val) => id.add(val.recordId));
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_people.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];
      // get item has been updated
      PeopleModel? peopleUpdated;
      datas.forEach((data) async {
        peopleUpdated = myPeople.firstWhere(
            (people) => people.id == int.parse(data['id'].toString()),
            orElse: () => PeopleModel(id: 0, name: "", city: "", tel: ""));
        if (peopleUpdated!.id != 0) {
          peopleUpdated!.name = data['name'];
          peopleUpdated!.tel = "0 ${data['tel']}";
          peopleUpdated!.city = data['city'];
        }
      });
    }
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
    loading = false;
    notifyListeners();
    return response;
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
