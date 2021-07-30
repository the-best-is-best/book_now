import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/component/round_check_box_component.dart';
import 'package:book_now/component/search_component.dart';
import 'package:book_now/modals/rel/people/create_rel_people_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget repSelectPeople() {
  final formKey = GlobalKey<FormState>();
  final searchPeopleController = TextEditingController();
  final paidController = TextEditingController();
  final supportController = TextEditingController();
  return Builder(
    builder: (context) {
      final myReportWatch = context.watch<ReportsProvider>();
      final myReportRead = context.read<ReportsProvider>();
      final myPeopleWatch = context.watch<PeopleProvider>();
      final myPeopleRead = context.read<PeopleProvider>();

      final myTravelWatch = context.watch<TravelProvider>();

      final myRelPeopleWatch = context.watch<RelPeopleProvider>();
      final myRelPeopleRead = context.read<RelPeopleProvider>();

      return Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Create Residence",
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
                Container(
                  child: Card(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 25),
                            width: MediaQuery.of(context).size.width,
                            child: Column(children: [
                              myPeopleWatch.myPeople.length > 20
                                  ? buildSearchComponent(
                                      context: context,
                                      searchController: searchPeopleController,
                                      searchTitle: "people name",
                                      onSubmit: (String? val) {
                                        myPeopleRead.searchPeople(val!);
                                        myReportRead.getNewData();
                                      },
                                    )
                                  : Container(),
                              SizedBox(
                                height: 10,
                              ),
                              DropdownButtonFormField<int?>(
                                  icon: null,
                                  hint: Text('Select People *'),
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
                                    myRelPeopleRead
                                        .changeSelectedPeople(value!);
                                    myReportRead.getNewData();
                                  },
                                  validator: (int? val) {
                                    if (val == null || val == 0) {
                                      return "select people please";
                                    }
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Center(
                                  child: Text(
                                    "Person Information",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              myRelPeopleWatch.selectedPeople != null
                                  ? Column(
                                      children: [
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "Number : ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3),
                                            TextSpan(
                                                text:
                                                    "${myPeopleWatch.myPeople.firstWhere((people) => people.id == myRelPeopleRead.selectedPeople).tel} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                          ]),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: "City : ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3),
                                            TextSpan(
                                                text:
                                                    "${myPeopleWatch.myPeople.firstWhere((people) => people.id == myRelPeopleRead.selectedPeople).city} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4),
                                          ]),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "Please select People",
                                      style:
                                          Theme.of(context).textTheme.headline4,
                                    )
                            ]),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            context: context,
                            controller: paidController,
                            label: 'Paid *',
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
                                supportController.text = val = "0";
                                return null;
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
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 25),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField<int?>(
                                icon: null,
                                hint: Text('Select Travel *'),
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
                                  myReportRead.getNewData();
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
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 25),
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField<int?>(
                                hint: Text('Select Room *'),
                                isExpanded: true,
                                value: myRelPeopleWatch.selectedRoom,
                                items: myRelPeopleWatch.relRoom.map((room) {
                                  int? value = myReportWatch
                                              .numberofBedsRemaining[room.id] ==
                                          null
                                      ? room.id
                                      : room.numbersOfBed >
                                              myReportWatch
                                                      .numberofBedsRemaining[
                                                  room.id]!
                                          ? room.id
                                          : 0;
                                  return value != 0
                                      ? DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            "Room : ${room.name.toString()} - Floor : ${room.floor} - single bed ${room.numbersOfBed - (room.bunkBed * 2)}  Bunk bed : ${room.bunkBed} - (*2)",
                                            overflow: TextOverflow.fade,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        )
                                      : DropdownMenuItem(
                                          value: 0,
                                          onTap: () => null,
                                          child: Text(
                                            "Room : ${room.name.toString()} - Floor : ${room.floor}",
                                            overflow: TextOverflow.fade,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2!
                                                .copyWith(color: Colors.grey),
                                          ),
                                        );
                                }).toList(),
                                onChanged: (value) {
                                  if (value != 0) {
                                    myRelPeopleRead.changeSelectedRoom(value);
                                    myReportRead.getNewData();
                                  }
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  "coupons :",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                defaultRoundCheckBox(
                                    (val) =>
                                        myRelPeopleRead.changecouponsState(val),
                                    myRelPeopleWatch.coupons),
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
                            if (paid + support >
                                myReportWatch.myProject!.price) {
                              await Flushbar(
                                title: 'Error',
                                message:
                                    "Paid + suppot > price !! ${myReportWatch.myProject!.price}",
                                duration: Duration(seconds: 3),
                              ).show(context);
                              return;
                            }
                            var createRelPeopleModel = CreateRelPeopleModel(
                              bones: myRelPeopleWatch.coupons ? 1 : 0,
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

                                    myRelPeopleRead.changeSelectedPeople(null);
                                    myRelPeopleRead.changeSelectedRoom(null);
                                    myRelPeopleRead.changeSelectedTravel(null);
                                    myRelPeopleRead.changecouponsState(false);

                                    myReportRead.getNewData();
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
    },
  );
}
