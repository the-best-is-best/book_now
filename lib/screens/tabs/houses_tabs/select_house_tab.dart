import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/screens/expanded/floors_expanded.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

Widget selectHousesTab() {
  return Column(
    children: [
      Builder(builder: (context) {
        final query = MediaQuery.of(context).size;
        final myHousesWatch = context.watch<HousesProvider>();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Select Houses",
              style: Theme.of(context).textTheme.headline4,
            )),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 3,
            ),
            Center(
              child: Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: myHousesWatch.myHouses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              width: query.width,
                              child: ExpandablePanel(
                                header:
                                    Text(myHousesWatch.myHouses[index].name),
                                collapsed: Container(),
                                expanded: Container(
                                  child: buildFloorsExpanded(
                                      myHousesWatch.myHouses[index]),
                                ),
                              ),
                            )));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 2,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    ],
  );
}