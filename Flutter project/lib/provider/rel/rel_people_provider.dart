import 'package:book_now/modals/rel/people/create_rel_people_model.dart';
import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/tabs/update/change_room/by_person.dart';
import 'package:book_now/screens/tabs/update/change_room/by_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RelPeopleProvider with ChangeNotifier {
  int tabIndex = 0;

  int? selectedPeople;
  int? selectedTravel;

  int? selectedhouseId;
  int? selectedRoom;
  List<RoomsModel> relRoom = [];

  RelPeopleModel? curPeople;
  RoomsModel? curRoomPeople;

  void getCurPeopeData(RoomsModel roomsModel, RelPeopleModel relPeopleModel) {
    curRoomPeople = roomsModel;
    curPeople = relPeopleModel;
  }

  void myHouse(int houseId) {
    selectedhouseId = houseId;
  }

  void backProject() {
    selectedhouseId = null;
  }

  void changeSelectedPeople(int? val) {
    selectedPeople = val;
    notifyListeners();
  }

  void changeSelectedTravel(int? val) {
    selectedTravel = val;
  }

  bool coupons = false;

  void changecouponsState(bool val) {
    coupons = val;
  }

  Future getRooms(List<RoomsModel> room, ReportsProvider report) async {
    relRoom = room
        .where((roomItem) => roomItem.houseId == report.myProject!.houseId)
        .toList();

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
      url: "rel/insert/create_rel_people.php",
      query: createRelPeople,
    );

    notifyListeners();

    return response;
  }

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

  Future changePeopleData({
    required int peopleId,
    required int paid,
    required int support,
    required int coupons,
    required int travelId,
    required int project,
    required String note,
  }) async {
    loading = true;
    notifyListeners();
    var data = {
      'people_id': peopleId,
      'paid': paid,
      'support': support,
      'project': project,
      'travel_id': travelId,
      'coupons': coupons,
      'note': note,
    };
    var response = await DioHelper.putData(
      url: "rel/update/update_people_data.php",
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
    byPerson(),
  ];
  void changeTabIndex(index) {
    tabIndex = index;
    notifyListeners();
  }
}
