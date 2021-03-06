import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatelessWidget {
  final HouseModel house;
  final int floor;

  const RoomScreen({required this.house, required this.floor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myRoomsRead = context.read<RoomsProvider>();
    final myRoomsWatch = context.watch<RoomsProvider>();
    final myCheckLoading = context.watch<CheckDataProvider>();
    return Scaffold(
      appBar: AppBar(title: Text("Rooms for - ${house.name} - floor: $floor ")),
      body: myCheckLoading.loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: SizedBox(
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
        },
        currentIndex: myRoomsWatch.tabIndex,
        unselectedFontSize: 15,
        type: BottomNavigationBarType.fixed,
        backgroundColor: mainColor,
        fixedColor: Colors.black,
        unselectedItemColor: Colors.brown,
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.select_all),
            label: 'Select',
          ),
        ],
      ),
    );
  }
}
