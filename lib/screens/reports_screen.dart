import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myCheckDataRead = context.read<CheckDataProvider>();
    final myReportRead = context.read<ReportsProvider>();
    final myReportWatch = context.watch<ReportsProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Report"),
      ),
      body: getDataFromServer(
          context: context,
          child: SingleChildScrollView(
            child: myReportWatch.tabsWidget[myReportWatch.tabIndex],
          )),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: myReportWatch.tabIndex,
        onTap: (val) {
          myReportRead.changeTabIndex(val);
          if (val == 1) {
            myCheckDataRead.listenDataChange();
          }
        },
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: mainColor,
        selectedItemColor: secColor,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.report), label: "Report"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled), label: "Overnight stay"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel), label: "Travel"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        ],
      ),
    );
  }
}
