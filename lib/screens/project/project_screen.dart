import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/component/menu/buildMenu.dart';
import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    final myProjectRead = context.read<MyProjectProvider>();
    final myProjectWatch = context.watch<MyProjectProvider>();
    final myCheckDataRead = context.read<CheckDataProvider>();

    return getDataFromServer(
      context: context,
      child: AdvancedDrawer(
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
        drawer: buildMenu(0, context),
        child: Scaffold(
          appBar: buildAppBar("My Project", _advancedDrawerController),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                width: myProjectWatch.tabIndex == 0
                    ? MediaQuery.of(context).size.width / 1.1
                    : null,
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: myProjectWatch.tabsWidget[myProjectWatch.tabIndex],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            onTap: (val) {
              myProjectRead.changeTabIndex(val);
              if (val == 1) {
                myCheckDataRead.listenDataChange();
              }
            },
            currentIndex: myProjectWatch.tabIndex,
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
