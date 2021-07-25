import 'package:book_now/modals/people/people_model.dart';
import 'package:flutter/foundation.dart';

class RelPeopleProvider with ChangeNotifier {
  int? selectedPeople;
  int? selectedTravel;

  void changeSelectedPeople(int? val) {
    selectedPeople = val;
    notifyListeners();
  }

  void changeSelectedTravel(int? val) {
    selectedTravel = val;
  }
}
