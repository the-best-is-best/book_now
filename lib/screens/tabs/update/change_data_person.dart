import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/component/round_check_box_component.dart';
import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeDataPerson extends StatefulWidget {
  final RelPeopleModel people;
  final RoomsModel room;

  const ChangeDataPerson(this.people, this.room, {Key? key}) : super(key: key);

  @override
  State<ChangeDataPerson> createState() => _ChangeDataPersonState();
}

class _ChangeDataPersonState extends State<ChangeDataPerson> {
  final formKey = GlobalKey<FormState>();

  final searchPeopleController = TextEditingController();

  final paidController = TextEditingController();

  final supportController = TextEditingController();

  final noteController = TextEditingController();

  bool firstLoad = true;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;

    final reportWatch = context.watch<ReportsProvider>();
    final relPeopleWatch = context.watch<RelPeopleProvider>();
    final relPeopleRead = context.watch<RelPeopleProvider>();

    final myTravelWatch = context.watch<TravelProvider>();

    if (firstLoad) {
      relPeopleRead.getCurPeopeData(widget.room, widget.people);

      relPeopleRead.changeSelectedTravel(widget.people.travelId);

      relPeopleRead.changecouponsState(widget.people.bones);

      paidController.text = widget.people.paid.toString();
      supportController.text = widget.people.support.toString();

      noteController.text = widget.people.note;
      firstLoad = false;
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Change data person")),
      body: getDataServer(
        context: context,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                  "Data Person - ${relPeopleWatch.curPeople!.peopleName}",
                  style: Theme.of(context).textTheme.headline3,
                )),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  thickness: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Conference price : ${reportWatch.myProject!.price}",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Form(
                    key: formKey,
                    child: Column(
                      children: [
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
                        const SizedBox(
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
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          thickness: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Remaining : ${reportWatch.myProject!.price - widget.people.paid - widget.people.support}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Divider(
                          thickness: 3,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<int?>(
                              icon: null,
                              hint: const Text('Select Travel *'),
                              value: relPeopleWatch.selectedTravel,
                              items: myTravelWatch.myTravel
                                  .map((travel) => DropdownMenuItem(
                                        value: travel.id,
                                        child: Text(
                                          travel.name,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                relPeopleRead.changeSelectedTravel(value!);
                              },
                              validator: (int? val) {
                                if (val == null || val == 0) {
                                  return "select travel plz";
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Opacity(
                          opacity: widget.people.bones ? 0 : 1,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  "coupons :",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                defaultRoundCheckBox(
                                    (val) =>
                                        relPeopleRead.changecouponsState(val),
                                    relPeopleWatch.coupons),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                            context: context,
                            controller: noteController,
                            type: TextInputType.name,
                            validate: null,
                            label: 'note'),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: query.width * .3,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                formKey.currentState!.save();
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                int paid = int.parse(paidController.text);
                                int support = int.parse(supportController.text);
                                if (paid + support >
                                    reportWatch.myProject!.price) {
                                  await Flushbar(
                                    title: 'Error',
                                    message:
                                        "Paid + suppot > price !! ${reportWatch.myProject!.price}",
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                  return;
                                }
                                relPeopleRead
                                    .changePeopleData(
                                  peopleId: widget.people.peopleId,
                                  paid: paid,
                                  support: support,
                                  travelId: relPeopleWatch.selectedTravel!,
                                  coupons: relPeopleWatch.coupons ? 1 : 0,
                                  project: reportWatch.myProject!.id,
                                  note: noteController.text,
                                )
                                    .then((response) {
                                  var data = response.data;

                                  if (data['messages'][0] ==
                                      "People data updated") {
                                    DioHelper.postNotification().then((_) {
                                      relPeopleRead
                                          .loadingEnd()
                                          .then((_) async {
                                        paidController.text =
                                            supportController.text = "";

                                        relPeopleRead
                                            .changeSelectedTravel(null);
                                        relPeopleRead.changecouponsState(false);
                                        Navigator.pop(context);
                                        await Flushbar(
                                          title: 'Success',
                                          message: "Updated",
                                          duration: const Duration(seconds: 3),
                                        ).show(context);
                                      });
                                    });
                                  } else {
                                    relPeopleRead.loadingEnd().then((_) async {
                                      List<dynamic> messages = data['messages'];
                                      for (int i = 0;
                                          i < messages.length;
                                          i++) {
                                        await Flushbar(
                                          title: 'Error',
                                          message: messages[i],
                                          duration: const Duration(seconds: 3),
                                        ).show(context);
                                      }
                                    });
                                  }
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the Widgets.
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text("Send"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(Icons.send),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
