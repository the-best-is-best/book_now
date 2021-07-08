import 'package:book_now/modals/houses/house_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildFloorsExpanded(HouseModel myHouses) => Builder(
      builder: (context) {
        List<int> floors = [];
        if (myHouses.floor > 0) {
          for (int i = 0; i < myHouses.floor; i++) {
            floors.add(i + 1);
          }
        }
        final query = MediaQuery.of(context).size;
        final widthGrid = query.width * 5 / 320;
        final itemRowCount = widthGrid.toInt();
        print(itemRowCount);
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
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.plusCircle),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            StaggeredGridView.countBuilder(
              shrinkWrap: true,
              crossAxisCount: 5,
              itemCount: floors.length == 0 ? 1 : floors.length,
              itemBuilder: (_, int index) {
                return floors.length > 0
                    ? ElevatedButton(
                        onPressed: () {},
                        child: Text(floors[index].toString()),
                      )
                    : Text("No floors");
              },
              staggeredTileBuilder: (int index) => StaggeredTile.count(1, 1),
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
            ),
          ],
        );
      },
    );
