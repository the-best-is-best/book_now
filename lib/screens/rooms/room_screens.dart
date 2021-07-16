import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatelessWidget {
  final HouseModel house;
  final int floor;

  const RoomScreen({required this.house, required this.floor});
  @override
  Widget build(BuildContext context) {
    final myCheckDataRead = context.read<CheckDataProvider>();
    final myRoomsRead = context.read<RoomsProvider>();
    final myRoomsWatch = context.watch<RoomsProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Rooms for - ${house.name} - floor: $floor ")),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: myRoomsWatch.tabIndex == 0
                ? MediaQuery.of(context).size.width / 1.1
                : null,
            child: Card(
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: myRoomsWatch.tabsWidget[myRoomsWatch.tabIndex],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        onTap: (val) {
          myRoomsRead.changeTabIndex(val);
          if (val == 1) {
            myCheckDataRead.listenDataChange();
          }
        },
        currentIndex: myRoomsWatch.tabIndex,
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
    );
  }
}
