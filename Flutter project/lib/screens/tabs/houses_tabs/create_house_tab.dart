import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/houses/create_house_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget createHouseTab() {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController floorNamberController = TextEditingController();

  return Builder(
    builder: (context) {
      final myHousesRead = context.read<HousesProvider>();
      final myHousesWatch = context.watch<HousesProvider>();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Create Houses",
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
                      controller: houseNameController,
                      label: 'House Name *',
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
                      controller: floorNamberController,
                      label: 'Total floors *',
                      type: TextInputType.number,
                      validate: (String? val) {
                        if (val == null || val.isEmpty) {
                          return "empty !!";
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
                  myHousesWatch.loading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          child: const Text("Create"),
                          onPressed: () async {
                            _keyForm.currentState!.save();
                            if (!_keyForm.currentState!.validate()) {
                              return;
                            }
                            _keyForm.currentState!.save();

                            CreateHouseModel createHouseModel =
                                CreateHouseModel(
                              name: houseNameController.text,
                              floor: int.parse(
                                floorNamberController.text,
                              ),
                            );
                            myHousesRead
                                .createHouseClicked(createHouseModel)
                                .then(
                              (response) async {
                                var data = response.data;

                                if (data['messages'][0] == "House Created") {
                                  DioHelper.postNotification().then((_) {
                                    myHousesRead.loadingEnd().then((_) async {
                                      houseNameController.text =
                                          floorNamberController.text = "";
                                      await Flushbar(
                                        title: 'Success',
                                        message: "Added",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    });
                                  });
                                } else {
                                  myHousesRead.loadingEnd().then((_) async {
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
