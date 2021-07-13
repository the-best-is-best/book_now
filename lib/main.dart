import 'dart:async';

import 'package:book_now/listen_socket/listen_socket.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/screens/create_select_screen.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'db/db_init.dart';
import 'network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DBInit.init();

  DioHelper.init();
  initializeDateFormatting();
  ListenSocket.init();

  runApp(RunMyApp());
}

class RunMyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: CheckDataProvider()),
      ChangeNotifierProvider.value(value: MyProjectProvider()),
      ChangeNotifierProvider.value(value: HousesProvider()),
      ChangeNotifierProvider.value(value: FloorProvider()),
      ChangeNotifierProvider.value(value: RoomsProvider()),
      ChangeNotifierProvider.value(value: PeopleProvider()),
      ChangeNotifierProvider.value(value: ReportsProvider()),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final checkDataRead = context.read<CheckDataProvider>();
    final housesDataRead = context.read<HousesProvider>();
    final floorDataRead = context.read<FloorProvider>();
    final roomsDataRead = context.read<RoomsProvider>();
    final peopleDataRead = context.read<PeopleProvider>();

    return MaterialApp(
      supportedLocales: [
        Locale("en"),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Book Now',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: mainColor,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(15),
            textStyle: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: bottonColor),
          ),
        ),
      ),
      home: FutureBuilder(
        future: checkDataRead.getListenData().then((_) {
          if (checkDataRead.insertHouses.length > 0) {
            housesDataRead
                .getHouses(checkDataRead.insertHouses)
                .then((_) => floorDataRead.getFloors(housesDataRead.myHouses));
          }
        }).then((_) {
          if (checkDataRead.insertRooms.length > 0) {
            roomsDataRead.getRooms(checkDataRead.insertRooms);
          }
        }).then((_) {
          if (checkDataRead.insertPeople.length > 0) {
            peopleDataRead.getPeople(checkDataRead.insertPeople);
          }
        }),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return CreateSelectScreen();
          }
        },
      ),
    );
  }
}

Stream listenDBDelay() async* {
  await Future<void>.delayed(const Duration(seconds: 1), () => print(1));

  await Future<void>.delayed(const Duration(seconds: 1));
}
