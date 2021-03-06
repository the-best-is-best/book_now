import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/rooms/add_bunk_bed.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class RoomDetailsScreen extends StatefulWidget {
  final RoomsModel room;

  const RoomDetailsScreen({required this.room, Key? key}) : super(key: key);

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  final _keyForm = GlobalKey<FormState>();
  final newNumOfBedController = TextEditingController();
  final newNumOfBunkBedController = TextEditingController();

  bool firstload = false;

  @override
  Widget build(BuildContext context) {
    final myHouseRead = context.read<HousesProvider>();
    final myRoomRead = context.read<RoomsProvider>();
    final myRoomWatch = context.watch<RoomsProvider>();
    final myHouse = myHouseRead.myHouses
        .firstWhere((house) => house.id == widget.room.houseId);
    if (!firstload) {
      newNumOfBedController.text = widget.room.numbersOfBed.toString();
      newNumOfBunkBedController.text = widget.room.bunkBed.toString();
      firstload = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${myHouse.name} - Room  ${widget.room.name}"),
        actions: [
          IconButton(
            icon: myRoomWatch.editRoomActive
                ? const FaIcon(FontAwesomeIcons.eye)
                : const FaIcon(FontAwesomeIcons.edit),
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
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      myRoomWatch.editRoomActive
                          ? Column(
                              children: [
                                Form(
                                  key: _keyForm,
                                  child: Column(
                                    children: [
                                      defaultFormField(
                                          context: context,
                                          controller: newNumOfBedController,
                                          label: 'New number of bed',
                                          type: TextInputType.number,
                                          validate: (String? val) {
                                            if (val == null || val.isEmpty) {
                                              return 'empty !!';
                                            }
                                            int? convertToInt =
                                                int.tryParse(val);
                                            if (convertToInt == null) {
                                              return "Number not valid";
                                            }
                                            return null;
                                          }),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      defaultFormField(
                                          context: context,
                                          controller: newNumOfBunkBedController,
                                          label: 'New bunk bed',
                                          type: TextInputType.number,
                                          validate: (String? val) {
                                            if (val == null || val.isEmpty) {
                                              newNumOfBunkBedController.text =
                                                  val = 0.toString();
                                              return null;
                                            }
                                            int? convertToInt =
                                                int.tryParse(val);
                                            if (convertToInt == null) {
                                              return "Number not valid";
                                            }
                                            if (int.parse(val) * 2 >
                                                int.parse(newNumOfBedController
                                                    .text)) {
                                              return "Number of Bunk Bed issues";
                                            }
                                            return null;
                                          }),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                myRoomWatch.loading
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                        child: const Text("Edit"),
                                        onPressed: () {
                                          _keyForm.currentState!.save();
                                          if (!_keyForm.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          _keyForm.currentState!.save();

                                          myRoomRead
                                              .updateRoom(
                                            addBunkBed: AddBunkBed(
                                                room: widget.room.name,
                                                floor: widget.room.floor,
                                                houseId: widget.room.houseId,
                                                bunkBed: int.parse(
                                                    newNumOfBunkBedController
                                                        .text),
                                                numbersOfBed: int.parse(
                                                    newNumOfBedController
                                                        .text)),
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
                                                          Navigator.pop(
                                                              context);
                                                          await Flushbar(
                                                            title: 'Success',
                                                            message: "Updated",
                                                            duration:
                                                                const Duration(
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
                                                      duration: const Duration(
                                                          seconds: 3),
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
                          : Column(
                              children: [
                                Text(
                                  "Number of bed : ${widget.room.numbersOfBed}",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Number of Bunk Bed : ${widget.room.bunkBed}",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Singe bed : ${widget.room.numbersOfBed - (widget.room.bunkBed * 2)}",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Bunk bed : ${(widget.room.bunkBed)} - (*2) ",
                                  style: Theme.of(context).textTheme.headline3,
                                ),
                              ],
                            ),
                      const SizedBox(
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
