import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/screens/rooms/room_details_screen.dart';
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

        final List<RoomsModel> curRoomes = myRoomWatch.myRooms
            .where((room) => room.houseId == houseId && room.floor == floor)
            .toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Select Room",
              style: Theme.of(context).textTheme.headline1,
            )),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 3,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: SizedBox(
                  width: query.width,
                  child: curRoomes.isNotEmpty
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
                                            const Duration(microseconds: 500),
                                        type: PageTransitionType.fade,
                                        child: RoomDetailsScreen(
                                          room: curRoomes[index],
                                        )));
                              },
                              child: Text(curRoomes[index].name.toString()),
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              const StaggeredTile.count(1, 1),
                          mainAxisSpacing: 5.0,
                          crossAxisSpacing: 5.0,
                        )
                      : Center(
                          child: Text(
                            "No Rooms",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      }),
    ],
  );
}
