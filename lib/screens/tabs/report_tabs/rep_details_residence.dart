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

      return Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Residence",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
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
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: query.width * .4,
                              child: Center(
                                  child: Text(
                                "Name",
                                overflow: TextOverflow.fade,
                              ))),
                          Container(
                            width: 2,
                            color: Colors.grey,
                          ),
                          Container(
                              width: query.width * .15,
                              child: Center(child: Text("Floor"))),
                          Container(
                              width: query.width * .15,
                              child: Center(child: Text("Room"))),
                          Container(
                            width: 2,
                            color: Colors.grey,
                          ),
                          Container(
                              width: query.width * .2,
                              child: Center(child: Text("Change"))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: myReportWatch.myRelPeople.length > 20
                          ? myReportWatch.loadNewRelPeopleData
                              ? height * (height * .40 / 640)
                              : height * (height * .45 / 640)
                          : myReportWatch.loadNewRelPeopleData
                              ? height * (height * .66 / 640)
                              : height * (height * .68 / 640),
                      child: NotificationListener(
                        child: myReportWatch.loadingSearch
                            ? Center(child: CircularProgressIndicator())
                            : ListView.separated(
                                controller: scrollListView,
                                shrinkWrap: true,
                                itemCount: myReportWatch.searched
                                    ? myReportWatch.searchRelPeople.length
                                    : myReportWatch.relPeopleData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 25,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            width: query.width * .4,
                                            child: Center(
                                                child: Text(myReportWatch
                                                        .searched
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
                                        Container(
                                          width: query.width * .15,
                                          child: Center(
                                            child: Text(myReportWatch.searched
                                                ? myReportWatch
                                                    .searchRelPeople[index]
                                                    .floor
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
                                        Container(
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
                                                            .relPeopleData[
                                                                index]
                                                            .roomId)
                                                    .name
                                                    .toString()),
                                          ),
                                        ),
                                        Container(
                                          width: 2,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          width: query.width * .2,
                                          child: Center(
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              icon: Icon(Icons.change_circle),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        duration: Duration(
                                                            microseconds: 500),
                                                        type: PageTransitionType
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
                                                                      .myRelPeople[
                                                                          index]
                                                                      .roomId),
                                                        )));
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(
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
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        )
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      );
    },
  );
}
