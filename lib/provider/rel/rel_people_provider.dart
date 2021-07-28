import 'package:book_now/modals/rel/people/create_rel_people_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RelPeopleProvider with ChangeNotifier {
  int? selectedPeople;
  int? selectedTravel;

  int? selectedhouseId;
  int? selectedRoom;
  List<RoomsModel> relRoom = [];

  void changeSelectedPeople(int? val) {
    selectedPeople = val;
    notifyListeners();
  }

  void changeSelectedTravel(int? val) {
    selectedTravel = val;
  }

  bool coupons = false;

  void changecouponsState(val) {
    coupons = val;
  }

  void changeSelectedHouse(int? val) {
    selectedhouseId = val;
  }

  Future getRooms(List<RoomsModel> room) async {
    relRoom =
        room.where((roomItem) => roomItem.houseId == selectedhouseId).toList();
    notifyListeners();
  }

  void changeSelectedRoom(int? val) {
    selectedRoom = val;
  }

  bool loading = false;
  Future sendData(CreateRelPeopleModel createRelPeopleModel) async {
    loading = true;
    notifyListeners();
    var createRelPeople = createRelPeopleModel.toJson();
    var response = await DioHelper.postData(
      url: "rel/insert_update/create_rel_people.php",
      query: createRelPeople,
    );

    notifyListeners();

    return response;
  }

  Future loadingEnd() async {
    loading = false;
    notifyListeners();
  }
}
