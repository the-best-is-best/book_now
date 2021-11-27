import 'package:book_now/screens/project/project_screen.dart';
import 'package:book_now/screens/houses/houses_screen.dart';
import 'package:book_now/screens/people/people_screen.dart';
import 'package:book_now/screens/travel/travel_screen.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

Widget buildMenu(int curPage, BuildContext context) {
  return SafeArea(
    child: ListTileTheme(
      textColor: Colors.white,
      iconColor: Colors.white,
      selectedColor: mainColor,
      selectedTileColor: Colors.black54,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            selected: curPage == 0 ? true : false,
            onTap: curPage == 0
                ? null
                : () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: const Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: const ProjectScreen()));
                  },
            leading: const FaIcon(
              FontAwesomeIcons.projectDiagram,
            ),
            title: const Text(
              'My Project',
            ),
          ),
          ListTile(
            selected: curPage == 1 ? true : false,
            onTap: curPage == 1
                ? null
                : () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: const Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: const HousesScreen()));
                  },
            leading: const FaIcon(FontAwesomeIcons.houseUser),
            title: const Text('Houses'),
          ),
          ListTile(
            selected: curPage == 2 ? true : false,
            onTap: curPage == 2
                ? null
                : () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: const Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: const PeopleScreen()));
                  },
            leading: const Icon(Icons.people_alt),
            title: const Text('People'),
          ),
          ListTile(
            selected: curPage == 3 ? true : false,
            onTap: curPage == 3
                ? null
                : () {
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: const Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: const TravelScreen()));
                  },
            leading: const Icon(Icons.travel_explore),
            title: const Text('Travel'),
          ),
          /*
          ListTile(
            selected: curPage == 4 ? true : false,
            onTap: curPage == 4
                ? null
                : () {
                    checkData.getMaxPage();
                    checkData.getDataPage(1);

                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            duration: Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: HistoryScreen()));
                  },
            leading: Icon(Icons.history),
            title: Text('History'),
          ),*/
        ],
      ),
    ),
  );
}
