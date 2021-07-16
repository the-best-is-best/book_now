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
//import 'db/db.dart';
import 'network/dio_helper.dart';

void main() {
//  WidgetsFlutterBinding.ensureInitialized();
  // await DB.init();

  DioHelper.init();
  initializeDateFormatting();
  //ListenSocket.init();

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
    final checkDataWatch = context.read<CheckDataProvider>();

    final housesDataRead = context.read<HousesProvider>();
    final housesDataWatch = context.watch<HousesProvider>();

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
      home: CreateSelectScreen(),
    );
  }
}
