import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/rel/rel_houses_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:book_now/screens/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

FutureBuilder<Null> getDataFromServer({
  required BuildContext context,
  required Widget child,
}) {
  final CheckDataProvider checkDataRead = context.read<CheckDataProvider>();
  final CheckDataProvider checkDataWatch = context.watch<CheckDataProvider>();

  final MyProjectProvider myProjecRead = context.read<MyProjectProvider>();
  final ReportsProvider reportRead = context.read<ReportsProvider>();
  final ReportsProvider reportWatch = context.watch<ReportsProvider>();

  final HousesProvider housesDataRead = context.read<HousesProvider>();
  final HousesProvider housesDataWatch = context.watch<HousesProvider>();

  final FloorProvider floorDataRead = context.read<FloorProvider>();

  final RoomsProvider roomsDataRead = context.watch<RoomsProvider>();
  final PeopleProvider peopleDataRead = context.read<PeopleProvider>();
  final TravelProvider travelDataRead = context.read<TravelProvider>();

  final RelHousesProvider relHousesRead = context.read<RelHousesProvider>();

  return FutureBuilder(
    future: checkDataRead.getListenData().then((val) async {
      if (val == true && checkDataWatch.insertProject.length > 0) {
        myProjecRead.getData(checkDataWatch.insertProject).then((val) {
          if (val != null) {
            reportRead.goToProject(val);

            Navigator.pushReplacement(
                context,
                PageTransition(
                    duration: Duration(microseconds: 500),
                    type: PageTransitionType.fade,
                    child: ReportsScreen()));
          }
        });
      }
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

      if (val == true && checkDataWatch.insertTravel.length > 0) {
        travelDataRead.getTravel(checkDataWatch.insertTravel);
      }

      if (val == true && checkDataWatch.updateTravel.length > 0) {
        travelDataRead.getUpdateTravel(checkDataWatch.updateTravel);
      }
      if (val == true && checkDataWatch.insertRelHouses.length > 0) {
        relHousesRead.getDataRelHouse(
          checkDataWatch.insertRelHouses,
        );
      }

      if (val == true &&
          reportWatch.myProject > 0 &&
          checkDataWatch.deleteRelHouses.length > 0) {
        relHousesRead.getUDeleteDataRelHouse(
            checkDataWatch.deleteRelHouses, reportWatch.myProject);
      }
    }),
    builder: (context, AsyncSnapshot snapshot) {
      return child;
    },
  );
}
