import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/change_room_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget byRoom() {
  return Builder(
    builder: (context) {
      final query = MediaQuery.of(context).size;
      final padding = MediaQuery.of(context).padding;
      final height =
          query.height - padding.top - padding.bottom - kToolbarHeight;

      final myRoomWatch = context.watch<RoomsProvider>();
      final reportsWatch = context.watch<ReportsProvider>();

      final myReportRead = context.read<ReportsProvider>();

      final changeRoomWatch = context.watch<ChangeRoomProvider>();
      final changeRoomRead = context.read<ChangeRoomProvider>();

      final RoomsModel roomPeople = changeRoomWatch.roomPeople!;
      final List<RoomsModel> curRoomes = myRoomWatch.myRooms
          .where((room) => room.houseId == roomPeople.houseId)
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
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 3,
          ),
          Center(
            child: Container(
              child: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: query.width * .5,
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
                        width: query.width * .2,
                        child: Center(child: Text("Floor"))),
                    Container(
                      width: 2,
                      color: Colors.grey,
                    ),
                    Container(
                        width: query.width * .25,
                        child: Center(child: Text("Change"))),
                  ],
                ),
              ),
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
            height: height * (height * .68 / 640),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: curRoomes.length,
              itemBuilder: (BuildContext context, int index) {
                return Opacity(
                  opacity: curRoomes[index].id == changeRoomWatch.roomPeople!.id
                      ? .5
                      : reportsWatch
                                  .numberofBedsRemaining[curRoomes[index].id] !=
                              null
                          ? reportsWatch.numberofBedsRemaining[
                                      curRoomes[index].id]! <
                                  curRoomes[index].numbersOfBed
                              ? 1
                              : .5
                          : 1,
                  child: Container(
                    height: 25,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: query.width * .5,
                            child: Center(
                              child: Text(curRoomes[index].name.toString()),
                            )),
                        Container(
                          width: 2,
                          color: Colors.grey,
                        ),
                        Container(
                          width: query.width * .2,
                          child: Center(
                            child: Text(curRoomes[index].floor.toString()),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: Colors.grey,
                        ),
                        Container(
                          width: query.width * .25,
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              icon: Icon(Icons.change_circle),
                              onPressed: curRoomes[index].id ==
                                      changeRoomWatch.roomPeople!.id
                                  ? null
                                  : reportsWatch.numberofBedsRemaining[
                                              curRoomes[index].id] !=
                                          null
                                      ? reportsWatch.numberofBedsRemaining[
                                                  curRoomes[index].id]! <
                                              curRoomes[index].numbersOfBed
                                          ? () => changeRoomRead
                                                  .changeRoom(
                                                      project: reportsWatch
                                                          .myProject!.id,
                                                      peopleId: changeRoomWatch
                                                          .people!.id,
                                                      roomId:
                                                          curRoomes[index].id)
                                                  .then((response) async {
                                                var data = response.data;
                                                if (data['messages'][0] ==
                                                    "People room updated") {
                                                  DioHelper.postNotification()
                                                      .then((_) async {
                                                    changeRoomRead.loadingEnd();

                                                    Navigator.pop(context);
                                                    myReportRead.getNewData();
                                                    await Flushbar(
                                                      title: 'Success',
                                                      message: "Added",
                                                      duration:
                                                          Duration(seconds: 3),
                                                    ).show(context);
                                                  });
                                                } else {
                                                  changeRoomRead.loadingEnd();
                                                  List<dynamic> messages =
                                                      data['messages'];
                                                  for (int i = 0;
                                                      i < messages.length;
                                                      i++) {
                                                    await Flushbar(
                                                      title: 'Error',
                                                      message: messages[i],
                                                      duration:
                                                          Duration(seconds: 3),
                                                    ).show(context);
                                                  }
                                                }
                                              })
                                          : null
                                      : () => changeRoomRead
                                              .changeRoom(
                                                  project: reportsWatch.myProject!.id,
                                                  peopleId: changeRoomWatch.people!.id,
                                                  roomId: curRoomes[index].id)
                                              .then((response) async {
                                            var data = response.data;
                                            if (data['messages'][0] ==
                                                "People room updated") {
                                              DioHelper.postNotification()
                                                  .then((_) async {
                                                changeRoomRead.loadingEnd();
                                                myReportRead.getNewData();

                                                Navigator.pop(context);

                                                await Flushbar(
                                                  title: 'Success',
                                                  message: "Added",
                                                  duration:
                                                      Duration(seconds: 3),
                                                ).show(context);
                                              });
                                            } else {
                                              changeRoomRead.loadingEnd();
                                              List<dynamic> messages =
                                                  data['messages'];
                                              for (int i = 0;
                                                  i < messages.length;
                                                  i++) {
                                                await Flushbar(
                                                  title: 'Error',
                                                  message: messages[i],
                                                  duration:
                                                      Duration(seconds: 3),
                                                ).show(context);
                                              }
                                            }
                                          }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  thickness: 2,
                );
              },
            ),
          ),
        ],
      );
    },
  );
}
