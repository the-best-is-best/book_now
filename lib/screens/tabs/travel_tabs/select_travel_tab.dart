import 'package:book_now/provider/travel_provider.dart';
import 'package:book_now/screens/travel/travel_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget selectTravelTab() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Builder(builder: (context) {
        final query = MediaQuery.of(context).size;

        final myTravelWatch = context.watch<TravelProvider>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Select Travel",
              style: Theme.of(context).textTheme.headline4,
            )),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 5,
            ),
            myTravelWatch.myTravel.length > 0
                ? buildListView(
                    myTravelWatch: myTravelWatch,
                    query: query,
                  )
                : Center(
                    child: Text(
                      "No travel",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
          ],
        );
      }),
    ],
  );
}

ListView buildListView({
  required TravelProvider myTravelWatch,
  required Size query,
}) {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: myTravelWatch.myTravel.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
            width: query.width,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        duration: Duration(microseconds: 500),
                        type: PageTransitionType.fade,
                        child: TravelDetailsScreen(
                            travel: myTravelWatch.myTravel[index])));
              },
              child: Text(myTravelWatch.myTravel[index].name),
            )),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider(
        thickness: 2,
      );
    },
  );
}
