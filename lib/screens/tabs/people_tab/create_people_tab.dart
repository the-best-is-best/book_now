import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/people/create_people_model.dart';
import 'package:book_now/modals/people/people_model.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget createPeopleTab() {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController peopleNameController = TextEditingController();
  TextEditingController telController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  return Builder(
    builder: (context) {
      final myPeopleRead = context.read<PeopleProvider>();
      final myPeopleWatch = context.watch<PeopleProvider>();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Create People",
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
          Center(
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  defaultFormField(
                      context: context,
                      controller: peopleNameController,
                      label: 'People Name',
                      type: TextInputType.text,
                      validate: (String? val) {
                        if (val == null || val.isEmpty || val.length < 3) {
                          return "min 3 characters";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      context: context,
                      controller: telController,
                      label: 'Telephone',
                      type: TextInputType.number,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          return "Empty !!";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      context: context,
                      controller: cityController,
                      label: 'City',
                      type: TextInputType.text,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          return "empty !!";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  myPeopleWatch.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text("Create"),
                          onPressed: () {
                            _keyForm.currentState!.save();
                            if (!_keyForm.currentState!.validate()) {
                              return;
                            }
                            _keyForm.currentState!.save();
                            CreatePeopleModel createPeopleModel =
                                CreatePeopleModel(
                                    name: peopleNameController.text,
                                    tel: telController.text,
                                    city: cityController.text);
                            myPeopleRead
                                .createPeopleClicked(createPeopleModel)
                                .then(
                              (response) async {
                                var data = response.data;
                                if (response.statusCode == 201) {
                                  peopleNameController.text = telController
                                      .text = cityController.text = "";

                                  await Flushbar(
                                    title: 'Success',
                                    message: "Added",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                } else {
                                  // myPeopleRead.insertFiled();
                                  if (data['statusCode'] >= 400 &&
                                      data['success'] == false) {
                                    List<dynamic> messages = data['messages'];
                                    for (int i = 0; i < messages.length; i++) {
                                      await Flushbar(
                                        title: 'Error',
                                        message: messages[i],
                                        duration: Duration(seconds: 3),
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
