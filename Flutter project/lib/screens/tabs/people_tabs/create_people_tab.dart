import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/people/create_people_model.dart';
import 'package:book_now/network/dio_helper.dart';
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
            style: Theme.of(context).textTheme.headline1,
          )),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 3,
          ),
          const SizedBox(
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
                      label: 'People Name *',
                      type: TextInputType.text,
                      validate: (String? val) {
                        if (val == null || val.isEmpty || val.length < 3) {
                          return "min 3 characters";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      context: context,
                      controller: telController,
                      label: 'Telephone',
                      type: TextInputType.number,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          telController.text = val = "0";
                          return null;
                        }
                        int? convertToInt = int.tryParse(val);
                        if (convertToInt == null) {
                          return "Number not valid";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      context: context,
                      controller: cityController,
                      label: 'City *',
                      type: TextInputType.text,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          return "empty !!";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  myPeopleWatch.loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          child: const Text("Create"),
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
                                if (data['messages'][0] == "People Created") {
                                  DioHelper.postNotification().then((_) {
                                    myPeopleRead.loadingEnd().then((_) async {
                                      peopleNameController.text = telController
                                          .text = cityController.text = "";
                                      await Flushbar(
                                        title: 'Success',
                                        message: "Added",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    });
                                  });
                                } else {
                                  myPeopleRead.loadingEnd().then((_) async {
                                    List<dynamic> messages = data['messages'];
                                    for (int i = 0; i < messages.length; i++) {
                                      await Flushbar(
                                        title: 'Error',
                                        message: messages[i],
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }
                              },
                            );
                          },
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      );
    },
  );
}
