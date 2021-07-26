import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/component/round_check_box_component.dart';
import 'package:book_now/component/search_component.dart';
import 'package:book_now/modals/rel/people/create_rel_people_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/rooms_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepSelectPeople extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final searchPeopleController = TextEditingController();
  final searchHouseController = TextEditingController();

  final paidController = TextEditingController();
  final supportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final myReportWatch = context.watch<ReportsProvider>();

    final myPeopleWatch = context.watch<PeopleProvider>();
    final myPeopleRead = context.read<PeopleProvider>();

    final myHouseWatch = context.watch<HousesProvider>();
    final myHouseRead = context.read<HousesProvider>();

    final myTravelWatch = context.watch<TravelProvider>();

    final myRelPeopleWatch = context.watch<RelPeopleProvider>();
    final myRelPeopleRead = context.read<RelPeopleProvider>();

    final myRoomWatch = context.read<RoomsProvider>();
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Text(
                "Residence",
                style: Theme.of(context).textTheme.headline4,
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
              Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Card(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: [
                            myPeopleWatch.myPeople.length > 20
                                ? buildSearchComponent(
                                    context: context,
                                    searchController: searchPeopleController,
                                    searchTitle: "people name",
                                    onSubmit: (String? val) {
                                      myPeopleRead.searchPeople(val!);
                                    },
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField<int?>(
                                icon: null,
                                hint: Text('Select People'),
                                value: myRelPeopleWatch.selectedPeople,
                                items: searchPeopleController.text.isEmpty
                                    ? myPeopleWatch.myPeople
                                        .map((people) => DropdownMenuItem(
                                              value: people.id,
                                              child: Text(
                                                people.name,
                                              ),
                                            ))
                                        .toList()
                                    : myPeopleWatch.searchMypeople
                                        .map((people) => DropdownMenuItem(
                                              value: people.id,
                                              child: Text(
                                                people.name,
                                              ),
                                            ))
                                        .toList(),
                                onChanged: (value) {
                                  myRelPeopleRead.changeSelectedPeople(value!);
                                },
                                validator: (int? val) {
                                  if (val == null || val == 0) {
                                    return "select people plz";
                                  }
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Center(
                                child: Text(
                                  "Person Information",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            myRelPeopleWatch.selectedPeople != null
                                ? Column(
                                    children: [
                                      Text(
                                        "Number : ${myPeopleWatch.myPeople.firstWhere((people) => people.id == myRelPeopleRead.selectedPeople).tel} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "City : ${myPeopleWatch.myPeople.firstWhere((people) => people.id == myRelPeopleRead.selectedPeople).city} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )
                                : Text(
                                    "Please select People",
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )
                          ]),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          context: context,
                          controller: paidController,
                          label: 'Paid',
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
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          context: context,
                          controller: supportController,
                          label: 'Support',
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
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<int?>(
                              icon: null,
                              hint: Text('Select Travel'),
                              value: myRelPeopleWatch.selectedTravel,
                              items: myTravelWatch.myTravel
                                  .map((travel) => DropdownMenuItem(
                                        value: travel.id,
                                        child: Text(
                                          travel.name,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                myRelPeopleRead.changeSelectedTravel(value!);
                              },
                              validator: (int? val) {
                                if (val == null || val == 0) {
                                  return "select travel plz";
                                }
                              }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              myHouseWatch.myHouses.length > 20
                                  ? buildSearchComponent(
                                      context: context,
                                      searchController: searchHouseController,
                                      searchTitle: "house name",
                                      onSubmit: (String? val) {
                                        myHouseRead.searchHouse(val!);
                                      },
                                    )
                                  : Container(),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField<int?>(
                                  icon: null,
                                  hint: Text('Select House'),
                                  value: myRelPeopleWatch.selectedhouseId,
                                  items: searchHouseController.text.isEmpty
                                      ? myHouseWatch.myHouses
                                          .map((house) => DropdownMenuItem(
                                                value: house.id,
                                                child: Text(
                                                  house.name,
                                                ),
                                              ))
                                          .toList()
                                      : myHouseWatch.searchMyHouse
                                          .map((house) => DropdownMenuItem(
                                                value: house.id,
                                                child: Text(
                                                  house.name,
                                                ),
                                              ))
                                          .toList(),
                                  onChanged: (value) {
                                    myRelPeopleRead.changeSelectedHouse(value!);
                                    myRelPeopleRead
                                        .getRooms(myRoomWatch.myRooms);
                                  },
                                  validator: (int? val) {
                                    if (val == null || val == 0) {
                                      return "select house plz";
                                    }
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<int?>(
                              hint: Text('Select Room'),
                              value: myRelPeopleWatch.selectedRoom,
                              items: myRelPeopleWatch.relRoom
                                  .map((room) => DropdownMenuItem(
                                        value: room.id,
                                        child: Text(
                                          "Room : ${room.name.toString()} - Floor : ${room.floor}",
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                myRelPeopleRead.changeSelectedRoom(value!);
                              },
                              validator: (int? val) {
                                if (val == null || val == 0) {
                                  return "select room plz";
                                }
                              }),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: [
                              Text(
                                "Bones :",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              defaultRoundCheckBox(
                                  myRelPeopleRead, myRelPeopleWatch),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 150,
                child: myRelPeopleWatch.loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Center the Widgets.
                          children: [
                            Text("Send"),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.send),
                          ],
                        ),
                        onPressed: () async {
                          formKey.currentState!.save();
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          int paid = int.parse(paidController.text);
                          int support = int.parse(supportController.text);
                          if (paid + support > myReportWatch.myProject!.price) {
                            await Flushbar(
                              title: 'Error',
                              message: "Paid + suppot > price !!",
                              duration: Duration(seconds: 3),
                            ).show(context);
                            return;
                          }
                          var createRelPeopleModel = CreateRelPeopleModel(
                            bones: myRelPeopleWatch.bones ? 1 : 0,
                            houseId: myRelPeopleWatch.selectedhouseId!,
                            roomId: myRelPeopleWatch.selectedRoom!,
                            travelId: myRelPeopleWatch.selectedTravel!,
                            peopleId: myRelPeopleWatch.selectedPeople!,
                            projectId: myReportWatch.myProject!.id,
                            paid: paid,
                            support: support,
                          );
                          myRelPeopleRead
                              .sendData(createRelPeopleModel)
                              .then((response) {
                            var data = response.data;

                            if (data['messages'][0] == "Residence Created") {
                              DioHelper.postNotification().then((_) {
                                myRelPeopleRead.loadingEnd().then((_) async {
                                  paidController.text =
                                      supportController.text = "";

                                  await Flushbar(
                                    title: 'Success',
                                    message: "Added",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                });
                              });
                            } else {
                              myRelPeopleRead.loadingEnd().then((_) async {
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
                        },
                      ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
