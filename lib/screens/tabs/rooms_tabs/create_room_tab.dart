import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/rooms/create_room_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget createRoomTab() {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

  final curRoomController = TextEditingController();
  final lastRoomController = TextEditingController();
  final numOfBedController = TextEditingController();

  return Builder(
    builder: (context) {
      final myRoomRead = context.read<RoomsProvider>();
      final myRoomWatch = context.watch<RoomsProvider>();
      final houseId = myRoomWatch.curHouse;
      final floor = myRoomWatch.curFloor;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Create Room",
            style: Theme.of(context).textTheme.headline1,
          )),
          SizedBox(
            height: 5,
          ),
          Divider(
            thickness: 3,
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  defaultFormField(
                      context: context,
                      controller: curRoomController,
                      label: 'First Room Number',
                      type: TextInputType.number,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          return "Empty !!";
                        }
                        int? convertToInt = int.tryParse(val);
                        if (convertToInt == null) {
                          return "Number not valid";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      context: context,
                      controller: lastRoomController,
                      label: 'Last Room Number',
                      type: TextInputType.number,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          lastRoomController.text = val = 0.toString();
                          return null;
                        }
                        int? convertToInt = int.tryParse(val);
                        if (convertToInt == null) {
                          return "Number not valid";
                        }
                        int last = int.parse(val);
                        int cur = int.parse(curRoomController.text);
                        if (last != 0 && last < cur) {
                          return "Last is less than number of room please + ${last - cur}";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      context: context,
                      controller: numOfBedController,
                      label: 'Number of bed',
                      type: TextInputType.number,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          return "Empty !!";
                        }
                        int? convertToInt = int.tryParse(val);
                        if (convertToInt == null) {
                          return "Number not valid";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  myRoomWatch.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text("Create"),
                          onPressed: () {
                            _keyForm.currentState!.save();
                            if (!_keyForm.currentState!.validate()) {
                              return;
                            }
                            _keyForm.currentState!.save();
                            List<int> rooms = [];
                            int last = int.parse(lastRoomController.text);
                            int cur = int.parse(curRoomController.text);
                            if (last == 0 || last == cur) {
                              CreateRoomModel createRoomModel = CreateRoomModel(
                                  houseId: houseId,
                                  name: cur.toString(),
                                  floor: floor,
                                  numbersOfBed:
                                      int.parse(numOfBedController.text));

                              myRoomRead
                                  .createRoomClicked(createRoomModel)
                                  .then((response) async {
                                var data = response.data;
                                if (response.statusCode == 201) {
                                  DioHelper.postNotification().then((_) =>
                                      myRoomRead.loadingEnd().then((_) async {
                                        curRoomController.text =
                                            lastRoomController.text =
                                                numOfBedController.text = "";
                                        await Flushbar(
                                          title: 'Success',
                                          message: "Added",
                                          duration: Duration(seconds: 3),
                                        ).show(context);
                                      }));
                                } else {
                                  myRoomRead.loadingEnd().then((_) async {
                                    List<dynamic> messages = data['messages'];
                                    for (int i = 0; i < messages.length; i++) {
                                      await Flushbar(
                                        title: 'Error',
                                        message: messages[i],
                                        duration: Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }
                              });
                            } else {
                              for (int i = cur; i <= last; i++) {
                                rooms.add(i);
                              }
                              rooms.sort((a, b) => a.compareTo(b));
                              for (int i = 0; i < rooms.length; i++) {
                                CreateRoomModel createRoomModel =
                                    CreateRoomModel(
                                        houseId: houseId,
                                        name: rooms[i].toString(),
                                        floor: floor,
                                        numbersOfBed:
                                            int.parse(numOfBedController.text));

                                myRoomRead
                                    .createRoomClicked(createRoomModel)
                                    .then((response) async {
                                  var data = response.data;
                                  if (data['messages'][0] == "Room Created") {
                                    myRoomRead.loadingEnd().then((_) async {
                                      curRoomController.text =
                                          lastRoomController.text =
                                              numOfBedController.text = "";
                                      await Flushbar(
                                        title: 'Success',
                                        message: "Added",
                                        duration: Duration(seconds: 3),
                                      ).show(context);
                                    });
                                  } else {
                                    myRoomRead.loadingEnd().then((_) async {
                                      List<dynamic> messages = data['messages'];
                                      for (int i = 0;
                                          i < messages.length;
                                          i++) {
                                        await Flushbar(
                                          title: 'Error',
                                          message: messages[i],
                                          duration: Duration(seconds: 3),
                                        ).show(context);
                                      }
                                    });
                                  }
                                });
                              }
                              DioHelper.postNotification();
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      );
    },
  );
}
