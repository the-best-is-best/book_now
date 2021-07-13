import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/people/people_model.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PeopleDetailsScreen extends StatelessWidget {
  final PeopleModel people;

  PeopleDetailsScreen({
    required this.people,
  });
  final _keyForm = GlobalKey<FormState>();
  final newNamePeopleController = TextEditingController();
  final newTelController = TextEditingController();
  final newcityController = TextEditingController();

  bool firstload = false;
  @override
  Widget build(BuildContext context) {
    final myPeopleRead = context.read<PeopleProvider>();
    final myPeopleWatch = context.watch<PeopleProvider>();

    final myPeople = myPeopleRead.myPeople
        .firstWhere((people) => people.id == this.people.id);
    if (!firstload) {
      newNamePeopleController.text = people.name;
      newTelController.text = people.tel.toString();
      newcityController.text = people.city;
      firstload = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("${myPeople.name} "),
        actions: [
          IconButton(
            icon: myPeopleWatch.editRoomActive
                ? FaIcon(FontAwesomeIcons.eye)
                : FaIcon(FontAwesomeIcons.edit),
            onPressed: () {
              myPeopleRead.inEdit();
            },
          )
        ],
      ),
      body: myPeopleWatch.editRoomActive
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SingleChildScrollView(
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
                              Column(
                                children: [
                                  Form(
                                    key: _keyForm,
                                    child: defaultFormField(
                                        context: context,
                                        controller: newNamePeopleController,
                                        label: 'New Name',
                                        type: TextInputType.text,
                                        validate: (String? val) {
                                          if (val != null && val.isEmpty) {
                                            return 'empty !!';
                                          }
                                          return null;
                                        }),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  defaultFormField(
                                      context: context,
                                      controller: newTelController,
                                      label: 'Telephone',
                                      type: TextInputType.number,
                                      validate: (String? val) {
                                        if (val != null && val.isEmpty) {
                                          return 'empty !!';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  defaultFormField(
                                      context: context,
                                      controller: newcityController,
                                      label: 'City',
                                      type: TextInputType.text,
                                      validate: (String? val) {
                                        if (val != null && val.isEmpty) {
                                          return 'empty !!';
                                        }
                                        return null;
                                      }),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  myPeopleWatch.loading
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

                                            myPeopleRead
                                                .updatePeople(
                                              id: people.id,
                                              name:
                                                  newNamePeopleController.text,
                                              tel: int.parse(
                                                  newTelController.text),
                                              city: newcityController.text,
                                            )
                                                .then(
                                              (response) async {
                                                var data = response.data;
                                                if (response.statusCode ==
                                                    201) {
                                                  newNamePeopleController.text =
                                                      newTelController.text =
                                                          newcityController
                                                              .text = "";
                                                  Navigator.pop(context);
                                                  await Flushbar(
                                                    title: 'Success',
                                                    message: "Updated",
                                                    duration:
                                                        Duration(seconds: 3),
                                                  ).show(context);
                                                } else {
                                                  if (data['statusCode'] >=
                                                          400 &&
                                                      data['success'] ==
                                                          false) {
                                                    List<dynamic> messages =
                                                        data['messages'];
                                                    for (int i = 0;
                                                        i < messages.length;
                                                        i++) {
                                                      await Flushbar(
                                                        title: 'Error',
                                                        message: messages[i],
                                                        duration: Duration(
                                                            seconds: 3),
                                                      ).show(context);
                                                    }
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        ),
                                ],
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
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Card(
                    elevation: 20,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Name : ${people.name}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              "Telephone : ${people.tel}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              "City : ${people.city}",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 20,
                            ),
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
