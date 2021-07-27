import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

FutureBuilder getDataServer({
  required BuildContext context,
  required Widget child,
}) {
  final CheckDataProvider checkDataRead = context.read<CheckDataProvider>();
  final CheckDataProvider checkDataWatch = context.watch<CheckDataProvider>();

  final MyProjectProvider myProjectRead = context.read<MyProjectProvider>();

  final HousesProvider housesDataRead = context.read<HousesProvider>();
  final HousesProvider housesDataWatch = context.watch<HousesProvider>();

  final FloorProvider floorDataRead = context.read<FloorProvider>();

  final RoomsProvider roomsDataRead = context.read<RoomsProvider>();

  final PeopleProvider peopleDataRead = context.read<PeopleProvider>();
  final TravelProvider travelDataRead = context.read<TravelProvider>();

  final ReportsProvider myReportRead = context.read<ReportsProvider>();

  final ReportsProvider myReportWatch = context.watch<ReportsProvider>();

  return FutureBuilder(
    future: checkDataRead.getMAinListenData().then((val) async {
      if (val == true) {
        checkDataRead.displayLoading(true);
        if (checkDataWatch.insertProject.length > 0) {
          myProjectRead.getData(checkDataWatch.insertProject);
        }
        if (checkDataWatch.insertHouses.length > 0) {
          housesDataRead
              .getHouses(checkDataWatch.insertHouses)
              .then((_) => floorDataRead.getFloors(housesDataWatch.myHouses));
        }
        if (checkDataWatch.updateHouses.length > 0) {
          housesDataRead
              .getUpdateHouses(checkDataWatch.updateHouses)
              .then((_) => floorDataRead.getFloors(housesDataRead.myHouses));
        }
        if (checkDataWatch.insertRooms.length > 0) {
          roomsDataRead.getRooms(checkDataWatch.insertRooms);
        }
        if (checkDataWatch.updateRooms.length > 0) {
          roomsDataRead.getUpdateRoom(checkDataWatch.updateRooms);
        }
        if (checkDataWatch.insertPeople.length > 0) {
          peopleDataRead.getPeople(checkDataWatch.insertPeople);
        }
        if (checkDataWatch.updatePeople.length > 0) {
          peopleDataRead.getUpdatePeople(checkDataWatch.updatePeople);
        }
        if (checkDataWatch.insertTravel.length > 0) {
          travelDataRead.getTravel(checkDataWatch.insertTravel);
        }

        if (checkDataWatch.updateTravel.length > 0) {
          await travelDataRead.getUpdateTravel(checkDataWatch.updateTravel);
        }
        checkDataRead.endMainList();
        checkDataRead.displayLoading(false);
      }

      if (myReportWatch.myProject != null) {
        checkDataRead.getRelListenData().then((val) async {
          if (val == true) {
            checkDataRead.displayLoading(true);
            if (checkDataWatch.insertRelPeople.length > 0) {
              myReportRead
                  .getDataRelPeople(checkDataWatch.insertRelPeople)
                  .then((_) async {
                myReportRead.getnumberofBedsRemaining();
              });
            }
            checkDataRead.endRelList();
            checkDataRead.displayLoading(false);
          }
        });
      }
      checkDataRead.endedLoadDataFromServer();
    }),
    builder: (context, snapshot) => Container(
        width: MediaQuery.of(context).size.width > 750 ? 750 : null,
        child: Center(child: child)),
  );
}
