import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/component/menu/buildMenu.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class PeopleScreen extends StatefulWidget {
  @override
  _PeopleScreenState createState() => _PeopleScreenState();
}

class _PeopleScreenState extends State<PeopleScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    final myPeopleRead = context.read<PeopleProvider>();
    final myPeopleWatch = context.watch<PeopleProvider>();

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
      drawer: buildMenu(2, context),
      child: Scaffold(
        appBar: buildAppBar("People", _advancedDrawerController),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: myPeopleWatch.tabIndex == 0
                  ? MediaQuery.of(context).size.width / 1.1
                  : null,
              child: Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: myPeopleWatch.tabsWidget[myPeopleWatch.tabIndex],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          onTap: (val) {
            myPeopleRead.changeTabIndex(val);
          },
          currentIndex: myPeopleWatch.tabIndex,
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
