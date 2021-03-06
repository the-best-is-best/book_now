import 'package:book_now/modals/listen_model/listen_data_model.dart';
import 'package:book_now/modals/rooms/add_bunk_bed.dart';
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

  Future getRooms(List<ListenDataModel> listenData) async {
    List<int> id = [];
    for (var val in listenData) {
      id.add(val.recordId);
    }
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_rooms.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];

      datas.forEach((data) {
        myRooms.add(RoomsModel.fromJson(data));
      });
    }
    myRooms.sort((a, b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  Future getUpdateRoom(List<ListenDataModel> listenData) async {
    List<int> id = [];
    for (var val in listenData) {
      id.add(val.recordId);
    }
    Map<String, dynamic> data = {};
    data = id.toMap((e) => MapEntry("id[${e - 1}]", e));

    var response =
        await DioHelper.getData(url: 'get_data/get_rooms.php', query: data);
    if (response.statusCode == 201) {
      var datas = response.data['data'];

// get item has been updated
      datas.forEach((data) async {
        RoomsModel? roomUpdated;
        roomUpdated = myRooms.firstWhere(
            (room) =>
                room.name == data['name'] &&
                room.floor == data['floor'] &&
                room.houseId == data['house_id'], orElse: () {
          return RoomsModel(
              id: 0,
              name: 0,
              floor: 0,
              houseId: 0,
              numbersOfBed: 0,
              bunkBed: 0);
        });

        if (roomUpdated.id != 0) {
          roomUpdated.numbersOfBed = data['numbers_of_bed'];
        }
      });
    }

    notifyListeners();
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

  Future loadingEnd() async {
    loading = false;
    notifyListeners();
  }

  Future updateRoom({required AddBunkBed addBunkBed}) async {
    loading = true;
    notifyListeners();
    var data = addBunkBed.toJson();
    var response = await DioHelper.putData(
      url: "update_data/room_update.php",
      query: data,
    );

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
