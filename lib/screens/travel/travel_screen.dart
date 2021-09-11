import 'package:book_now/component/app_bar_component.dart';
import 'package:book_now/component/menu/build_menu.dart';
import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class TravelScreen extends StatefulWidget {
  const TravelScreen({Key? key}) : super(key: key);

  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final myTravelRead = context.read<TravelProvider>();
    final myTravelWatch = context.watch<TravelProvider>();
    final myCheckLoading = context.watch<CheckDataProvider>();
    return getDataServer(
      context: context,
      child: AdvancedDrawer(
        openRatio: .75,
        backdropColor: Colors.blueGrey,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        childDecoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        drawer: buildMenu(3, context),
        child: Scaffold(
          appBar: buildAppBar("Travel", _advancedDrawerController),
          body: myCheckLoading.loading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: DoubleBackToCloseApp(
                    snackBar: const SnackBar(
                      content: Text('Tap back again to leave'),
                    ),
                    child: SingleChildScrollView(
                      child: SizedBox(
                        width: myTravelWatch.tabIndex == 0
                            ? MediaQuery.of(context).size.width / 1.1
                            : null,
                        child: Card(
                          elevation: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: myTravelWatch
                                .tabsWidget[myTravelWatch.tabIndex],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            onTap: (val) {
              myTravelRead.changeTabIndex(val);
            },
            currentIndex: myTravelWatch.tabIndex,
            unselectedFontSize: 15,
            type: BottomNavigationBarType.fixed,
            backgroundColor: mainColor,
            fixedColor: Colors.black,
            unselectedItemColor: Colors.brown,
            // ignore: prefer_const_literals_to_create_immutables
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.create),
                label: 'Create',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.select_all),
                label: 'Select',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
