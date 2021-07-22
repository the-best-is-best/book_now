import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/modals/rel/create_rel_houses_model.dart';
import 'package:book_now/modals/rel/rel_houses_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/foundation.dart';
import '../../extention/to_map.dart';

class RelHousesProvider with ChangeNotifier {
  List<RelHousesModel> relHouses = [];
  List<CreateRelHousesModel> createRelHouses = [];

  Future getDataRelHouse(List<ListenDataModel> lisenData) async {
    List<int> id = [];

    lisenData.forEach((val) {
      id.add(val.recordId);
    });
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response = await DioHelper.getData(
        url: 'rel/get_data/get_rel_houses.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];

      // update list
      datas.forEach((data) {
        relHouses.add(RelHousesModel.fromJson(data));

        createRelHouses.add(CreateRelHousesModel(
          houseId: data['house_id'],
          active: data['active'] == 1 ? true : false,
          projectId: data['project_id'],
        ));
      });
    }
    relHouses.sort((a, b) => a.id.compareTo(b.id));
    createRelHouses.sort((a, b) => a.houseId.compareTo(b.houseId));
    print(createRelHouses.length);
    notifyListeners();
  }

  Future getUDeleteDataRelHouse(
      List<ListenDataModel> lisenData, project) async {
    List<int> id = [];

    lisenData.forEach((val) {
      id.add(val.recordId);
    });
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response = await DioHelper.getData(
        url: 'rel/get_data/get_rel_houses.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];

      // update list

      datas.forEach((data) async {
        relHouses.removeWhere((relHouse) =>
            relHouse.houseId == data['house_id'] &&
            relHouse.projectId == data['project_id']);

        createRelHouses.removeWhere((relHouse) =>
            relHouse.houseId == data['house_id'] &&
            relHouse.projectId == data['project_id']);
      });
    }
    relHouses.sort((a, b) => a.id.compareTo(b.id));

    notifyListeners();
  }

  void checkOrUnChec(
      {required int house, required bool checked, required int project}) {
    for (var relHouse in createRelHouses) {
      if (relHouse.houseId == house) {
        relHouse.active = checked;
        print(createRelHouses.length);

        return;
      }
    }
    createRelHouses.add(CreateRelHousesModel(
      houseId: house,
      active: checked,
      projectId: project,
    ));
    createRelHouses.sort((a, b) => a.houseId.compareTo(b.houseId));
  }

  bool loading = false;

  Future insertOrUpdateRelHouses() async {
    bool changeData = false;
    loading = true;
    notifyListeners();
    createRelHouses.forEach((val) async {
      var createRelHouse = val.toJson();
      await DioHelper.postData(
        url: "rel/insert_update/rel_houses.php",
        query: createRelHouse,
      );
      changeData = true;
    });

    loading = false;
    notifyListeners();

    return changeData;
  }
}
