import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatefulWidget {
  final RoomsModel room;

  const RoomDetailsScreen({
    required this.room,
  });

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  final _keyForm = GlobalKey<FormState>();
  final newNumOfBedController = TextEditingController();
  bool firstload = false;

  @override
  Widget build(BuildContext context) {
    final myHouseRead = context.read<HousesProvider>();
    final myRoomRead = context.read<RoomsProvider>();
    final myRoomWatch = context.watch<RoomsProvider>();
    final myHouse = myHouseRead.myHouses
        .firstWhere((house) => house.id == this.widget.room.houseId);
    if (!firstload) {
      newNumOfBedController.text = widget.room.numbersOfBed.toString();
      firstload = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${myHouse.name} - Room  ${widget.room.name}"),
        actions: [
          IconButton(
            icon: myRoomWatch.editRoomActive
                ? FaIcon(FontAwesomeIcons.eye)
                : FaIcon(FontAwesomeIcons.edit),
            onPressed: () {
              myRoomRead.inEdit();
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      myRoomWatch.editRoomActive
                          ? Column(
                              children: [
                                Form(
                                  key: _keyForm,
                                  child: defaultFormField(
                                      context: context,
                                      controller: newNumOfBedController,
                                      label: 'New number of bed',
                                      type: TextInputType.number,
                                      validate: (String? val) {
                                        if (val == null || val.isEmpty) {
                                          return 'empty !!';
                                        }
                                        int? convertToInt = int.tryParse(val);
                                        if (convertToInt == null) {
                                          return "Number not valid";
                                        }
                                        return null;
                                      }),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                myRoomWatch.loading
                                    ? CircularProgressIndicator()
                                    : ElevatedButton(
                                        child: Text("Edit"),
                                        onPressed: () {
                                          _keyForm.currentState!.save();
                                          if (!_keyForm.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          _keyForm.currentState!.save();

                                          myRoomRead
                                              .updateRoom(
                                            id: widget.room.name,
                                            floor: widget.room.floor,
                                            houseId: widget.room.houseId,
                                            newNumberOfBed: int.parse(
                                                newNumOfBedController.text),
                                          )
                                              .then(
                                            (response) async {
                                              var data = response.data;
                                              if (data['messages'][0] ==
                                                  "Room updated") {
                                                DioHelper.postNotification()
                                                    .then((_) => myRoomRead
                                                            .loadingEnd()
                                                            .then((_) async {
                                                          newNumOfBedController
                                                              .text = "";

                                                          Navigator.pop(
                                                              context);
                                                          await Flushbar(
                                                            title: 'Success',
                                                            message: "Updated",
                                                            duration: Duration(
                                                                seconds: 3),
                                                          ).show(context);
                                                        }));
                                              } else {
                                                myRoomRead
                                                    .loadingEnd()
                                                    .then((_) async {
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
                                                });
                                              }
                                            },
                                          );
                                        },
                                      ),
                              ],
                            )
                          : Text(
                              "Number of bed : ${widget.room.numbersOfBed}",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
