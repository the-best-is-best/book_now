import 'package:book_now/modals/floot_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/screens/floor_screen.dart';
import 'package:book_now/screens/room_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget buildFloorsExpanded(
        {required BuildContext context,
        required HouseModel myHouses,
        required int index}) =>
    Builder(
      builder: (context) {
        final floorWatch = context.watch<FloorProvider>();
        final roomRead = context.read<RoomsProvider>();

        FloorModel floors = floorWatch.myFloor[index];
        final query = MediaQuery.of(context).size;
        final widthGrid = query.width * 5 / 320;
        final itemRowCount = widthGrid.toInt();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Floors",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: Duration(microseconds: 500),
                            type: PageTransitionType.fade,
                            child: FloorRoom(
                              myHouse: myHouses,
                            )));
                  },
                  icon: FaIcon(FontAwesomeIcons.plusCircle),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: floors.floor[0] > 0
                  ? StaggeredGridView.countBuilder(
                      shrinkWrap: true,
                      crossAxisCount: itemRowCount,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: floors.floor.length,
                      itemBuilder: (_, int index) {
                        return ElevatedButton(
                          onPressed: () {
                            roomRead
                                .gotToRoom(
                                    house: myHouses.id,
                                    floor: floors.floor[index])
                                .then((_) => Navigator.push(
                                    context,
                                    PageTransition(
                                        duration: Duration(microseconds: 500),
                                        type: PageTransitionType.fade,
                                        child: RoomScreen(
                                          house: myHouses,
                                          floor: floors.floor[index],
                                        ))));
                          },
                          child: Text(floors.floor[index].toString()),
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
                        "No floors",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
            ),
          ],
        );
      },
    );
