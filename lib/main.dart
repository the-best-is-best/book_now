import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/create_project_screen.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: MyProjectProvider()),
        ChangeNotifierProvider.value(value: ReportsProvider()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Now',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        primaryColor: mainColor,
        scaffoldBackgroundColor: Colors.white70,
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
      home: CreateProjectScreen(),
      supportedLocales: [
        Locale('en', 'US'),
      ],
    );
  }
}
