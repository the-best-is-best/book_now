import 'package:book_now/component/form_field.dart';
import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/modals/rel/people/rel_people_model.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeDataPerson extends StatelessWidget {
  final RelPeopleModel people;
  final RoomsModel room;

  ChangeDataPerson(this.people, this.room);

  final searchPeopleController = TextEditingController();
  final paidController = TextEditingController();
  final supportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context).size;

    final reportWatch = context.watch<ReportsProvider>();
    final relPeopleWatch = context.watch<RelPeopleProvider>();
    final relPeopleRead = context.watch<RelPeopleProvider>();

    final myTravelWatch = context.watch<TravelProvider>();

    relPeopleRead.getCurPeopeData(room, people);

    relPeopleRead.changeSelectedTravel(relPeopleWatch.curPeople!.travelId);

    paidController.text = relPeopleWatch.curPeople!.paid.toString();
    supportController.text = relPeopleWatch.curPeople!.support.toString();
    return Scaffold(
      appBar: AppBar(title: Text("Change data person")),
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
                SizedBox(
                  height: 5,
                ),
                Divider(
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
                SizedBox(
                  height: 15,
                ),
                Form(
                    key: key,
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
                        SizedBox(
                          height: 5,
                        ),
                        Divider(
                          thickness: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Remaining : ${reportWatch.myProject!.price - int.parse(paidController.text) - int.parse(supportController.text)}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
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
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black38),
                          ),
                          padding:
                              EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                          width: MediaQuery.of(context).size.width,
                          child: DropdownButtonFormField<int?>(
                              icon: null,
                              hint: Text('Select Travel *'),
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
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: query.width * .2,
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the Widgets.
                                children: [
                                  Text("Send"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(Icons.send),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
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
