import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/project/project_screen.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myReportRead = context.read<ReportsProvider>();
    final myReportWatch = context.watch<ReportsProvider>();

    final myRelPeopleRead = context.read<RelPeopleProvider>();

    return getDataServer(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text("${myReportWatch.myProject!.projectName}"),
          leading: IconButton(
            onPressed: () {
              myReportRead.backProject();
              myRelPeopleRead.changeSelectedPeople(null);
              myRelPeopleRead.changeSelectedTravel(null);

              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      duration: Duration(microseconds: 500),
                      type: PageTransitionType.fade,
                      child: ProjectScreen()));
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: myReportWatch.tabsWidget[myReportWatch.tabIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: myReportWatch.tabIndex,
          onTap: (val) {
            myReportRead.changeTabIndex(val);
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: mainColor,
          selectedItemColor: secColor,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report"),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Overnight stay"),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          ],
        ),
      ),
    );
  }
}
