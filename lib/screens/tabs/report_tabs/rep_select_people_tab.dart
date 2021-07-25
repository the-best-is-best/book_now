import 'package:book_now/component/form_field.dart';
import 'package:book_now/component/search_component.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepSelectPeople extends StatelessWidget {
  final searchPeopleController = TextEditingController();

  final paidController = TextEditingController();
  final supportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          myPeopleWatch.myPeople.length > 0
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
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "City : ${myPeopleWatch.myPeople.firstWhere((people) => people.id == myRelPeopleRead.selectedPeople).city} ",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : Text(
                                  "Please select People",
                                  style: Theme.of(context).textTheme.headline6,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
