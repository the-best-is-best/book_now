import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/screens/create_select_screen.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'db/db_init.dart';
import 'network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBInit.init();
  DioHelper.int();
  initializeDateFormatting();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
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
    final housesDataWatch = context.watch<HousesProvider>();

    final floorDataRead = context.read<FloorProvider>();

    final roomsDataRead = context.read<RoomsProvider>();

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
          future: checkDataRead.getLisenData().then((_) {
            if (checkDataRead.insertHouses.length > 0) {
              housesDataRead
                  .getHouses(checkDataRead.insertHouses)
                  .then(
                      (_) => floorDataRead.getFloors(housesDataWatch.myHouses))
                  .then((_) {
                if (checkDataRead.insertRooms.length > 0) {
                  roomsDataRead.getRooms(checkDataRead.insertRooms);
                }
              });
            }
          }),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return CreateSelectScreen();
          }),
    );
  }
}
