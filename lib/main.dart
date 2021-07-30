import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:book_now/screens/project/project_screen.dart';
import 'package:book_now/style/main_style.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic("all_users");
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    GetDataListen.getData = false;
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    GetDataListen.getData = false;
  });

  DioHelper.init();

  initializeDateFormatting();
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
      ChangeNotifierProvider.value(value: TravelProvider()),
      ChangeNotifierProvider.value(value: ReportsProvider()),
      ChangeNotifierProvider.value(value: RelPeopleProvider()),
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    GetDataListen.getData = false;

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
        textTheme: TextTheme(
            headline1: MainStyle.getFontSize(context, 1),
            headline2: MainStyle.getFontSize(context, 2),
            headline3: MainStyle.getFontSize(context, 3),
            headline4: MainStyle.getFontSize(context, 4),
            headline5: MainStyle.getFontSize(context, 5),
            headline6: MainStyle.getFontSize(context, 6),
            bodyText1: MainStyle.getFontSize(context, 5),
            bodyText2: MainStyle.getFontSize(context, 6)),
        iconTheme: IconThemeData(color: mainColor),
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
      home: ProjectScreen(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
    );
  }
}
