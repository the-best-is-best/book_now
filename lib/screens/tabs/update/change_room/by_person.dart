import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/search_component.dart';
import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget byPerson() {
  final searchPeople = TextEditingController();
  final scrollListView = ScrollController();
  return Builder(builder: (context) {
    final myReportWatch = context.watch<ReportsProvider>();
    final myReportRead = context.read<ReportsProvider>();
    final allRoomsWatch = context.watch<RoomsProvider>();
    final changeRoomWatch = context.watch<RelPeopleProvider>();
    final changeRoomRead = context.read<RelPeopleProvider>();

    final query = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final height = query.height - padding.top - padding.bottom - kToolbarHeight;
    return getDataServer(
      context: context,
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                "Select Person",
                style: Theme.of(context).textTheme.headline1,
              )),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 3,
              ),
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
                        ? height * (height * .38 / 640)
                        : height * (height * .5 / 640)
                    : myReportWatch.loadNewRelPeopleData
                        ? height * (height * .63 / 640)
                        : height * (height * .8 / 640),
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
                            return Opacity(
                              opacity: myReportWatch.searched
                                  ? changeRoomWatch.curRoomPeople!.id ==
                                          myReportWatch
                                              .searchRelPeople[index].roomId
                                      ? .5
                                      : 1
                                  : changeRoomWatch.curRoomPeople!.id ==
                                          myReportWatch
                                              .relPeopleData[index].roomId
                                      ? .5
                                      : 1,
                              child: Container(
                                height: 25,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
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
                                    Container(
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
                                    Container(
                                      width: query.width * .15,
                                      child: Center(
                                        child: Text(myReportWatch.searched
                                            ? allRoomsWatch.myRooms
                                                .firstWhere((room) =>
                                                    room.id ==
                                                    myReportWatch
                                                        .searchRelPeople[index]
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
                                    Container(
                                      width: query.width * .2,
                                      child: Center(
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(Icons.change_circle),
                                          onPressed: myReportWatch.searched
                                              ? changeRoomWatch
                                                          .curRoomPeople!.id ==
                                                      myReportWatch
                                                          .searchRelPeople[
                                                              index]
                                                          .roomId
                                                  ? null
                                                  : () {
                                                      changeRoomRead.changeRoom(
                                                          project: myReportWatch
                                                              .myProject!.id,
                                                          peopleId:
                                                              changeRoomWatch
                                                                  .curPeople!
                                                                  .id,
                                                          roomId: myReportWatch
                                                              .searchRelPeople[
                                                                  index]
                                                              .roomId);

                                                      changeRoomRead
                                                          .changeRoom(
                                                              project:
                                                                  myReportWatch
                                                                      .myProject!
                                                                      .id,
                                                              peopleId:
                                                                  myReportWatch
                                                                      .searchRelPeople[
                                                                          index]
                                                                      .id,
                                                              roomId:
                                                                  changeRoomWatch
                                                                      .curPeople!
                                                                      .roomId)
                                                          .then(
                                                              (response) async {
                                                        var data =
                                                            response.data;
                                                        if (data['messages']
                                                                [0] ==
                                                            "People room updated") {
                                                          DioHelper
                                                                  .postNotification()
                                                              .then((_) async {
                                                            changeRoomRead
                                                                .loadingEnd();

                                                            Navigator.pop(
                                                                context);
                                                            await Flushbar(
                                                              title: 'Success',
                                                              message: "Added",
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                            ).show(context);
                                                          });
                                                        } else {
                                                          changeRoomRead
                                                              .loadingEnd();
                                                          List<dynamic>
                                                              messages =
                                                              data['messages'];
                                                          for (int i = 0;
                                                              i <
                                                                  messages
                                                                      .length;
                                                              i++) {
                                                            await Flushbar(
                                                              title: 'Error',
                                                              message:
                                                                  messages[i],
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                            ).show(context);
                                                          }
                                                        }
                                                      });
                                                    }
                                              : changeRoomWatch
                                                          .curRoomPeople!.id ==
                                                      myReportWatch
                                                          .relPeopleData[index]
                                                          .roomId
                                                  ? null
                                                  : () {
                                                      changeRoomRead.changeRoom(
                                                          project: myReportWatch
                                                              .myProject!.id,
                                                          peopleId:
                                                              changeRoomWatch
                                                                  .curPeople!
                                                                  .id,
                                                          roomId: myReportWatch
                                                              .relPeopleData[
                                                                  index]
                                                              .roomId);

                                                      changeRoomRead
                                                          .changeRoom(
                                                              project:
                                                                  myReportWatch
                                                                      .myProject!
                                                                      .id,
                                                              peopleId:
                                                                  myReportWatch
                                                                      .relPeopleData[
                                                                          index]
                                                                      .id,
                                                              roomId:
                                                                  changeRoomWatch
                                                                      .curPeople!
                                                                      .roomId)
                                                          .then(
                                                              (response) async {
                                                        var data =
                                                            response.data;
                                                        if (data['messages']
                                                                [0] ==
                                                            "People room updated") {
                                                          DioHelper
                                                                  .postNotification()
                                                              .then((_) async {
                                                            changeRoomRead
                                                                .loadingEnd();

                                                            Navigator.pop(
                                                                context);

                                                            await Flushbar(
                                                              title: 'Success',
                                                              message:
                                                                  "Updated",
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                            ).show(context);
                                                          });
                                                        } else {
                                                          changeRoomRead
                                                              .loadingEnd();
                                                          List<dynamic>
                                                              messages =
                                                              data['messages'];
                                                          for (int i = 0;
                                                              i <
                                                                  messages
                                                                      .length;
                                                              i++) {
                                                            await Flushbar(
                                                              title: 'Error',
                                                              message:
                                                                  messages[i],
                                                              duration:
                                                                  Duration(
                                                                      seconds:
                                                                          3),
                                                            ).show(context);
                                                          }
                                                        }
                                                      });
                                                    },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
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
      ),
    );
  });
}
