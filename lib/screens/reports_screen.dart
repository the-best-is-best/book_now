import 'package:book_now/provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reportsWatch = context.watch<ReportsProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Report"),
      ),
      body: null,
      bottomNavigationBar: BottomNavigationBar(
        items: [
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
