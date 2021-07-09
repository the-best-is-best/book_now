import 'package:book_now/modals/floot_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:flutter/foundation.dart';

class FloorProvider with ChangeNotifier {
  List<FloorModel> myFloor = [];

  bool loadFirstTime = false;
  Future getFloors(List<HouseModel> myHouses) async {
    if (!loadFirstTime) {
      int idFloor = 0;
      myHouses.forEach((house) {
        List<int> floors = [];

        idFloor++;
        if (house.floor > 0) {
          for (int i = 0; i < house.floor; i++) {
            floors.add(i + 1);
          }
        } else {
          floors.add(0);
        }
        myFloor.add(FloorModel(id: idFloor, houseId: house.id, floor: floors));
      });
      loadFirstTime = true;
      notifyListeners();
    }
  }
}
