import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:book_now/screens/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget selectProjectTab() {
  return Column(
    children: [
      Builder(
        builder: (context) {
          final myProjectWatch = context.watch<MyProjectProvider>();

          final reportsRead = context.read<ReportsProvider>();
          final relPeopleRead = context.read<RelPeopleProvider>();

          final checkDataRead = context.read<CheckDataProvider>();
          final checkDataWatch = context.watch<CheckDataProvider>();
          final myRoomWatch = context.watch<RoomsProvider>();

          final travelDataWatch = context.watch<TravelProvider>();

          final query = MediaQuery.of(context).size;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                "Select Project",
                style: Theme.of(context).textTheme.headline1,
              )),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                thickness: 3,
              ),
              Center(
                child: Container(
                  child: myProjectWatch.myProject.isNotEmpty
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: myProjectWatch.myProject.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: SizedBox(
                                  width: query.width,
                                  child: ElevatedButton(
                                    child: Text(myProjectWatch
                                        .myProject[index].projectName),
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                          context,
                                          PageTransition(
                                              duration: const Duration(
                                                  microseconds: 500),
                                              type: PageTransitionType.fade,
                                              child: const ReportsScreen()));
                                      reportsRead.getDataProject(
                                          myProjectWatch.myProject[index]);
                                      await checkDataRead
                                          .getRelListenData(fromProject: true)
                                          .then((val) async {
                                        if (val == true) {
                                          checkDataRead.displayLoading(true);

                                          if (checkDataRead
                                              .insertRelPeople.isNotEmpty) {
                                            await reportsRead
                                                .getDataRelPeople(
                                                    checkDataWatch
                                                        .insertRelPeople,
                                                    myRoomWatch.myRooms)
                                                .then((_) async {
                                              reportsRead
                                                  .getnumberofBedsRemaining();
                                            }).then((_) {
                                              reportsRead.getMaxPage();

                                              reportsRead.getDataPage(1);
                                            });
                                          }
                                          checkDataRead.endRelList();
                                          checkDataRead.displayLoading(false);

                                          relPeopleRead.myHouse(myProjectWatch
                                              .myProject[index].houseId);

                                          relPeopleRead
                                              .getRooms(myRoomWatch.myRooms);

                                          reportsRead.calcMangmentData(
                                              travelDataWatch.myTravel);
                                        }
                                      });
                                    },
                                  )),
                            ));
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Divider(
                              thickness: 2,
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            "No projects",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    ],
  );
}
