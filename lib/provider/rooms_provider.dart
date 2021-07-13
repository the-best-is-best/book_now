import 'package:book_now/modals/lisen_data_model.dart';
import 'package:book_now/modals/rooms/create_room_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/extention/to_map.dart';
import 'package:book_now/screens/tabs/rooms_tabs/create_room_tab.dart';
import 'package:book_now/screens/tabs/rooms_tabs/select_room_tab.dart';

import 'package:flutter/material.dart';

class RoomsProvider with ChangeNotifier {
  late int curHouse;
  late int curFloor;

  List<RoomsModel> myRooms = [];

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
    myRooms = [];
    datas.forEach((data) {
      myRooms.add(RoomsModel.fromJson(data));
    });
    return myRooms;
  }

  Future gotToRoom({required int house, required int floor}) async {
    curHouse = house;
    curFloor = floor;
  }

  bool loading = false;
  Future createRoomClicked(CreateRoomModel createRoomModel) async {
    loading = true;
    notifyListeners();
    var createRoom = createRoomModel.toJson();

    var response = await DioHelper.postData(
      url: "insert_data/create_room.php",
      query: createRoom,
    );
    return response;
  }

  void insertToList(RoomsModel data) {
    myRooms.add(data);
    loading = false;
    notifyListeners();
  }

  void insertFiled() {
    loading = false;
    notifyListeners();
  }

  Future updateRoom(
      {required int id,
      required int houseId,
      required int floor,
      required int newNumberOfBed}) async {
    loading = true;
    notifyListeners();
    Map<String, int> data = {
      "id": id,
      "floor": floor,
      "house_id": houseId,
      "numbers_of_bed": newNumberOfBed
    };
    var response = await DioHelper.putData(
      url: "update_data/room_update.php",
      query: data,
    );
    RoomsModel? roomUpdated;
    var resData = response.data;
    if (resData['messages'][0] == "Room updated") {
      roomUpdated = myRooms.firstWhere((room) =>
          room.name == id && room.floor == floor && room.houseId == houseId);
      roomUpdated.numbersOfBed = int.parse(resData['data']['numbers_of_bed']);
    }
    loading = false;
    notifyListeners();

    return response;
  }

  bool editRoomActive = false;
  void inEdit() {
    editRoomActive = !editRoomActive;
    notifyListeners();
  }

  int tabIndex = 0;
  List<Widget> tabsWidget = [
    createRoomTab(),
    selectRoomTab(),
  ];
  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
