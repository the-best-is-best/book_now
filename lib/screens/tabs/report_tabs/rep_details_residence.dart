import 'package:book_now/component/search_component.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/screens/change_room_residence.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget repDetailsResidenceTab() {
  final searchPeople = TextEditingController();
  final scrollListView = ScrollController();
  return Builder(
    builder: (context) {
      final myReportWatch = context.watch<ReportsProvider>();
      final myReportRead = context.read<ReportsProvider>();
      final allRoomsWatch = context.watch<RoomsProvider>();
      final query = MediaQuery.of(context).size;
      final padding = MediaQuery.of(context).padding;
      final height =
          query.height - padding.top - padding.bottom - kToolbarHeight;

      return Center(
        child: Column(
          children: [
            Text(
              "Residence",
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 3,
            ),
            Container(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Center(
                    child: myReportWatch.myRelPeople.length > 20
                        ? buildSearchComponent(
                            context: context,
                            searchController: searchPeople,
                            searchTitle: "People Name",
                            onSubmit: (val) {
                              myReportRead.searchInRelPeople(val);
                            })
                        : Container(),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: query.width * .4,
                          child: const Center(
                              child: Text(
                            "Name",
                            overflow: TextOverflow.fade,
                          ))),
                      Container(
                        width: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                          width: query.width * .15,
                          child: const Center(child: Text("Floor"))),
                      SizedBox(
                          width: query.width * .15,
                          child: const Center(child: Text("Room"))),
                      Container(
                        width: 2,
                        color: Colors.grey,
                      ),
                      SizedBox(
                          width: query.width * .2,
                          child: const Center(child: Text("Change"))),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: myReportWatch.myRelPeople.length > 20
                        ? myReportWatch.loadNewRelPeopleData
                            ? height * (height * .48 / 640)
                            : height * (height * .56 / 640)
                        : myReportWatch.loadNewRelPeopleData
                            ? height * (height * .63 / 640)
                            : height * (height * .70 / 640),
                    child: NotificationListener(
                      child: myReportWatch.loadingSearch
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              controller: scrollListView,
                              shrinkWrap: true,
                              itemCount: myReportWatch.searched
                                  ? myReportWatch.searchRelPeople.length
                                  : myReportWatch.relPeopleData.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 25,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                          width: query.width * .4,
                                          child: Center(
                                              child: Text(myReportWatch.searched
                                                  ? myReportWatch
                                                      .searchRelPeople[index]
                                                      .peopleName
                                                  : myReportWatch
                                                      .relPeopleData[index]
                                                      .peopleName))),
                                      Container(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: query.width * .15,
                                        child: Center(
                                          child: Text(myReportWatch.searched
                                              ? myReportWatch
                                                  .searchRelPeople[index].floor
                                                  .toString()
                                              : myReportWatch
                                                  .relPeopleData[index].floor
                                                  .toString()),
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: query.width * .15,
                                        child: Center(
                                          child: Text(myReportWatch.searched
                                              ? allRoomsWatch.myRooms
                                                  .firstWhere((room) =>
                                                      room.id ==
                                                      myReportWatch
                                                          .searchRelPeople[
                                                              index]
                                                          .roomId)
                                                  .name
                                                  .toString()
                                              : allRoomsWatch.myRooms
                                                  .firstWhere((room) =>
                                                      room.id ==
                                                      myReportWatch
                                                          .relPeopleData[index]
                                                          .roomId)
                                                  .name
                                                  .toString()),
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: query.width * .2,
                                        child: Center(
                                          child: IconButton(
                                            padding: const EdgeInsets.all(0),
                                            icon:
                                                const Icon(Icons.change_circle),
                                            onPressed:
                                                myReportWatch.dateServer
                                                        .isBefore(myReportWatch
                                                            .myProject!.endDate)
                                                    ? () {
                                                        myReportRead
                                                            .searchInRelPeople(
                                                                "");
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                duration:
                                                                    const Duration(
                                                                        microseconds:
                                                                            500),
                                                                type:
                                                                    PageTransitionType
                                                                        .fade,
                                                                child:
                                                                    ChangeRoomResidence(
                                                                  myReportWatch
                                                                          .myRelPeople[
                                                                      index],
                                                                  allRoomsWatch.myRooms.firstWhere((room) =>
                                                                      room.houseId ==
                                                                          myReportWatch
                                                                              .myRelPeople[
                                                                                  index]
                                                                              .houseId &&
                                                                      room.id ==
                                                                          myReportWatch
                                                                              .myRelPeople[index]
                                                                              .roomId),
                                                                )));
                                                      }
                                                    : null,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  thickness: 2,
                                );
                              }),
                      onNotification: (dynamic scroll) {
                        if (scroll is ScrollEndNotification &&
                            myReportWatch.curPage != myReportWatch.maxPage &&
                            scrollListView.position.maxScrollExtent ==
                                scroll.metrics.pixels) {
                          myReportWatch.getNexPage();
                        }

                        return true;
                      },
                    ),
                  ),
                ],
              ),
            ),
            myReportWatch.loadNewRelPeopleData
                ? Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                : Container()
          ],
        ),
      );
    },
  );
}
