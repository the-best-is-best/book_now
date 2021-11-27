import 'package:book_now/modals/floot_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:flutter/foundation.dart';

class FloorProvider with ChangeNotifier {
  List<FloorModel> myFloor = [];

  Future getFloors(List<HouseModel> myHouses) async {
    myFloor = [];

    for (var house in myHouses) {
      List<int> floors = [];
      if (house.floor > 0) {
        for (int i = 0; i < house.floor; i++) {
          floors.add(i + 1);
        }
      } else {
        floors.add(0);
      }
      myFloor.add(FloorModel(houseId: house.id, floor: floors));
    }
    notifyListeners();
  }
}
