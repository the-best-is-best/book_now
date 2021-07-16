import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FutureBuilder<Null> getDataFromServer({
  required BuildContext context,
  required Widget child,
}) {
  final CheckDataProvider checkDataRead = context.read<CheckDataProvider>();
  final CheckDataProvider checkDataWatch = context.watch<CheckDataProvider>();
  final HousesProvider housesDataRead = context.read<HousesProvider>();
  final FloorProvider floorDataRead = context.read<FloorProvider>();
  final HousesProvider housesDataWatch = context.watch<HousesProvider>();
  final RoomsProvider roomsDataRead = context.watch<RoomsProvider>();
  final PeopleProvider peopleDataRead = context.read<PeopleProvider>();

  return FutureBuilder(
    future: checkDataRead.getListenData().then((val) async {
      if (val == true && checkDataWatch.insertHouses.length > 0) {
        housesDataRead
            .getHouses(checkDataWatch.insertHouses)
            .then((_) => floorDataRead.getFloors(housesDataWatch.myHouses));
      }
      if (val == true && checkDataRead.updateHouses.length > 0) {
        housesDataRead
            .getUpdateHouses(checkDataWatch.updateHouses)
            .then((_) => floorDataRead.getFloors(housesDataWatch.myHouses));
      }
      if (val == true && checkDataWatch.insertRooms.length > 0) {
        roomsDataRead.getRooms(checkDataWatch.insertRooms);
      }

      if (val == true && checkDataWatch.updateRooms.length > 0) {
        roomsDataRead.getUpdateRoom(checkDataWatch.updateRooms);
      }

      if (val == true && checkDataWatch.insertPeople.length > 0) {
        peopleDataRead.getPeople(checkDataWatch.insertPeople);
      }

      if (val == true && checkDataWatch.updatePeople.length > 0) {
        peopleDataRead.getUpdatePeople(checkDataWatch.updatePeople);
      }
    }),
    builder: (context, AsyncSnapshot snapshot) {
      return child;
    },
  );
}
