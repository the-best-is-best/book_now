import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/travel/create_travel_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget createTravelTab() {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController travelNameController = TextEditingController();

  return Builder(
    builder: (context) {
      final myTravelRead = context.read<TravelProvider>();
      final myTravelWatch = context.watch<TravelProvider>();
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Create Travel",
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
                      controller: travelNameController,
                      label: 'Travel Name',
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
                  myTravelWatch.loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          child: const Text("Create"),
                          onPressed: () async {
                            _keyForm.currentState!.save();
                            if (!_keyForm.currentState!.validate()) {
                              return;
                            }
                            _keyForm.currentState!.save();

                            CreateTravelModel createTravelModel =
                                CreateTravelModel(
                              name: travelNameController.text,
                            );
                            myTravelRead
                                .createTravelClicked(createTravelModel)
                                .then(
                              (response) async {
                                var data = response.data;

                                if (data['messages'][0] == "Travel Created") {
                                  DioHelper.postNotification().then((_) =>
                                      myTravelRead.loadingEnd().then((_) async {
                                        travelNameController.text = "";
                                        await Flushbar(
                                          title: 'Success',
                                          message: "Added",
                                          duration: const Duration(seconds: 3),
                                        ).show(context);
                                      }));
                                } else {
                                  myTravelRead.loadingEnd().then((_) async {
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
