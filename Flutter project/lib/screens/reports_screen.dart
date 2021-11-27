import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/project/project_screen.dart';
import 'package:book_now/style/main_style.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myReportRead = context.read<ReportsProvider>();
    final myReportWatch = context.watch<ReportsProvider>();

    final myRelPeopleRead = context.read<RelPeopleProvider>();
    final myCheckLoading = context.watch<CheckDataProvider>();

    return getDataServer(
      context: context,
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text(myReportWatch.myProject!.projectName),
          leading: IconButton(
            onPressed: () async {
              myCheckLoading.destroyListenProject();
              myReportRead.backProject();
              myRelPeopleRead.changeSelectedPeople(null);
              myRelPeopleRead.changeSelectedTravel(null);
              myRelPeopleRead.changeSelectedRoom(null);
              myRelPeopleRead.changecouponsState(false);
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                      duration: const Duration(microseconds: 500),
                      type: PageTransitionType.fade,
                      child: const ProjectScreen()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: myCheckLoading.loading
            ? const Center(child: CircularProgressIndicator())
            : DoubleBackToCloseApp(
                snackBar: const SnackBar(
                  content: Text('Tap back again to leave'),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: myReportWatch.tabsWidget[myReportWatch.tabIndex],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: myReportWatch.tabIndex,
          onTap: (val) {
            myReportRead.changeTabIndex(val);
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: mainColor,
          selectedItemColor: secColor,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.report), label: "Report"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Overnight stay"),
            if (myReportWatch.dateServer
                .isBefore(myReportWatch.myProject!.endDate))
              const BottomNavigationBarItem(
                  icon: Icon(Icons.people), label: "People"),
          ],
        ),
      ),
    );
  }
}
