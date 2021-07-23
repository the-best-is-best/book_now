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

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Report"),
        leading: IconButton(
          onPressed: () {
            myReportRead.goToProject(0);
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
    );
  }
}
