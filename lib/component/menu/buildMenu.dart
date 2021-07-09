import 'package:book_now/screens/create_select_screen.dart';
import 'package:book_now/screens/houses_screen.dart';
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
                            duration: Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: CreateSelectScreen()));
                  },
            leading: FaIcon(
              FontAwesomeIcons.projectDiagram,
            ),
            title: Text(
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
                            duration: Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: HousesScreen()));
                  },
            leading: FaIcon(FontAwesomeIcons.houseUser),
            title: Text('Houses'),
          ),
          ListTile(
            selected: curPage == 2 ? true : false,
            onTap: curPage == 2 ? null : () {},
            leading: Icon(Icons.favorite),
            title: Text('Favourites'),
          ),
          ListTile(
            selected: curPage == 3 ? true : false,
            onTap: curPage == 3 ? null : () {},
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    ),
  );
}
