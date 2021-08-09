import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/provider/change_room_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ChangeRoomResidence extends StatelessWidget {
  final RelPeopleModel people;
  final RoomsModel room;

  const ChangeRoomResidence(this.people, this.room);

  @override
  Widget build(BuildContext context) {
    final changeRoomRead = context.read<ChangeRoomProvider>();
    final changeRoomWatch = context.watch<ChangeRoomProvider>();
    changeRoomRead.getRoomPeope(room, people);
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Room"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: changeRoomRead.tabsWidget[changeRoomWatch.tabIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: changeRoomWatch.tabIndex,
        onTap: (val) {
          changeRoomRead.changeTabIndex(val);
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: mainColor,
        selectedItemColor: secColor,
        items: [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.restroom), label: "Rooms"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        ],
      ),
    );
  }
}
