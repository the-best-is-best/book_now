import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatelessWidget {
  final HouseModel house;
  final int floor;

  const RoomScreen({required this.house, required this.floor});
  @override
  Widget build(BuildContext context) {
    final myRoomsWatch = context.watch<RoomsProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Rooms for - ${house.name} - floor: $floor ")),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: myRoomsWatch.tabIndex == 0
                ? MediaQuery.of(context).size.width / 1.1
                : null,
            height: myRoomsWatch.tabIndex == 0
                ? MediaQuery.of(context).size.height / 2
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
    );
  }
}
