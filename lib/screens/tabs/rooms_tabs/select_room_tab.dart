import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/screens/room_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget selectRoomTab() {
  return Column(
    children: [
      Builder(builder: (context) {
        final query = MediaQuery.of(context).size;
        final widthGrid = query.width * 5 / 320;
        final itemRowCount = widthGrid.toInt();

        final myRoomWatch = context.watch<RoomsProvider>();
        final houseId = myRoomWatch.curHouse;
        final floor = myRoomWatch.curFloor;

        final List<RoomsModel> curRoomes = myRoomWatch.myRoomes
            .where((room) => room.houseId == houseId && room.floor == floor)
            .toList();

        curRoomes.sort((a, b) => a.name.compareTo(b.name));

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Select Room",
              style: Theme.of(context).textTheme.headline4,
            )),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 3,
            ),
            Container(
                child: Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(
                          width: query.width,
                          child: curRoomes.length > 0
                              ? StaggeredGridView.countBuilder(
                                  shrinkWrap: true,
                                  crossAxisCount: itemRowCount,
                                  itemCount: curRoomes.length,
                                  itemBuilder: (_, int index) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                duration:
                                                    Duration(microseconds: 500),
                                                type: PageTransitionType.fade,
                                                child: RoomDetailsScreen(
                                                  house: houseId,
                                                  floor: floor,
                                                  room: curRoomes[index],
                                                )));
                                      },
                                      child: Text(
                                          curRoomes[index].name.toString()),
                                      style: ElevatedButton.styleFrom(
                                        shape: CircleBorder(),
                                      ),
                                    );
                                  },
                                  staggeredTileBuilder: (int index) =>
                                      StaggeredTile.count(1, 1),
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 5.0,
                                )
                              : Center(
                                  child: Text(
                                    "No Rooms",
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                        )))),
          ],
        );
      }),
    ],
  );
}
