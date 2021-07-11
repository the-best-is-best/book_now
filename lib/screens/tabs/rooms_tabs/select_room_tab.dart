import 'package:book_now/provider/rooms_provider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget selectRoomTab() {
  return Column(
    children: [
      Builder(builder: (context) {
        final query = MediaQuery.of(context).size;

        final myRoomsWatch = context.watch<RoomsProvider>();

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
            Center(
              child: Container(
                height: query.height,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: myRoomsWatch.myRoomes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Container(
                              width: query.width,
                              child: ExpandablePanel(
                                header: Text(myRoomsWatch.myRoomes[index].name
                                    .toString()),
                                collapsed: Container(),
                                expanded: Container(
                                  child: null,
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
