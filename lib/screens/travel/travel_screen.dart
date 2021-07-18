import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/component/menu/buildMenu.dart';
import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class TravelScreen extends StatefulWidget {
  @override
  _TravelScreenState createState() => _TravelScreenState();
}

class _TravelScreenState extends State<TravelScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  Widget build(BuildContext context) {
    final myCheckDataRead = context.read<CheckDataProvider>();
    final myTravelRead = context.read<TravelProvider>();
    final myTravelWatch = context.watch<TravelProvider>();

    return getDataFromServer(
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
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        drawer: buildMenu(3, context),
        child: Scaffold(
          appBar: buildAppBar("Travel", _advancedDrawerController),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: myTravelWatch.tabIndex == 0
                    ? MediaQuery.of(context).size.width / 1.1
                    : null,
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: myTravelWatch.tabsWidget[myTravelWatch.tabIndex],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            onTap: (val) {
              myTravelRead.changeTabIndex(val);
              if (val == 1) {
                myCheckDataRead.listenDataChange();
              }
            },
            currentIndex: myTravelWatch.tabIndex,
            unselectedFontSize: 15,
            type: BottomNavigationBarType.fixed,
            backgroundColor: mainColor,
            fixedColor: Colors.black,
            unselectedItemColor: Colors.brown,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.create),
                label: 'Create',
              ),
              BottomNavigationBarItem(
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
