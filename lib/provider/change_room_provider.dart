import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/screens/tabs/change_room/by_room.dart';
import 'package:flutter/material.dart';

class ChangeRoomProvider with ChangeNotifier {
  int tabIndex = 0;
  RoomsModel? roomPeople;
  RelPeopleModel? people;

  void getRoomPeope(RoomsModel roomsModel, RelPeopleModel relPeopleModel) {
    roomPeople = roomsModel;
    people = relPeopleModel;
  }

  bool loading = false;
  Future changeRoom(
      {required int peopleId,
      required int roomId,
      required int project}) async {
    loading = true;
    notifyListeners();
    var data = {'people_id': peopleId, 'room_id': roomId, 'project': project};
    var response = await DioHelper.putData(
      url: "rel/update/update_people_room.php",
      query: data,
    );

    notifyListeners();

    return response;
  }

  Future loadingEnd() async {
    loading = false;
    notifyListeners();
  }

  List<Widget> tabsWidget = [
    byRoom(),
  ];
  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
