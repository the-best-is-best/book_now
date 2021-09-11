import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/modals/travel/create_travel_model.dart';
import 'package:book_now/modals/travel/travel_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/travel_tabs/create_travel_tab.dart';
import 'package:book_now/screens/tabs/travel_tabs/select_travel_tab.dart';
import 'package:flutter/material.dart';
import '../extention/to_map.dart';

class TravelProvider with ChangeNotifier {
  List<TravelModel> myTravel = [];

//get data server
  Future getTravel(List<ListenDataModel> listenData) async {
// convert data to json
    List<int> id = [];
    for (var val in listenData) {
      id.add(val.recordId);
    }
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_travel.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];

      // update list
      datas.forEach((data) => myTravel.add(TravelModel.fromJson(data)));
    }

    notifyListeners();
  }

  Future getUpdateTravel(List<ListenDataModel> listenData) async {
    List<int> id = [];

    for (var val in listenData) {
      id.add(val.recordId);
    }
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_travel.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];
      TravelModel? travelUpdated;
      datas.forEach((data) async {
        travelUpdated = myTravel.firstWhere(
            (travel) => travel.id == int.parse(data['id'].toString()),
            orElse: () => TravelModel(id: 0, name: ""));
        if (travelUpdated!.id != 0) {
          travelUpdated!.name = data['name'];
        }
      });
    }

    notifyListeners();
  }

  bool loading = false;

  Future createTravelClicked(CreateTravelModel createTravelModel) async {
    loading = true;
    notifyListeners();
    var createTravel = createTravelModel.toJson();
    var response = await DioHelper.postData(
      url: "insert_data/create_travel.php",
      query: createTravel,
    );
    notifyListeners();

    return response;
  }

  Future updateTravel({
    required int id,
    required String name,
  }) async {
    loading = true;
    notifyListeners();
    Map<String, dynamic> data = {
      "id": id,
      "name": name,
    };
    var response = await DioHelper.putData(
      url: "update_data/travel_update.php",
      query: data,
    );
    notifyListeners();

    return response;
  }

  Future loadingEnd() async {
    loading = false;
    notifyListeners();
  }

  bool editTravelActive = false;
  void inEdit() {
    editTravelActive = !editTravelActive;
    notifyListeners();
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    createTravelTab(),
    selectTravelTab(),
  ];

  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
