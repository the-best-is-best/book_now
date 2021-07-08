import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/component/menu/buildMenu.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class HousesRoomsScreen extends StatefulWidget {
  @override
  _HousesRoomsScreenState createState() => _HousesRoomsScreenState();
}

class _HousesRoomsScreenState extends State<HousesRoomsScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final myHousesRead = context.read<HousesProvider>();
    final myHousesWatch = context.watch<HousesProvider>();

    return AdvancedDrawer(
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
      drawer: buildMenu(1, context),
      child: Scaffold(
        appBar: buildAppBar("Houses", _advancedDrawerController),
        body: FutureBuilder(
          future: myHousesRead.getHouses(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Container(
                  width: myHousesWatch.tabIndex == 0
                      ? MediaQuery.of(context).size.width / 1.1
                      : null,
                  height: myHousesWatch.tabIndex == 0
                      ? MediaQuery.of(context).size.height / 2
                      : null,
                  child: Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: myHousesWatch.tabsWidget[myHousesWatch.tabIndex],
                    ),
                  ),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          onTap: (val) {
            myHousesRead.changeTabIndex(val);
          },
          currentIndex: myHousesWatch.tabIndex,
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
    );
  }
}
