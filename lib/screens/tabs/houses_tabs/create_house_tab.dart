import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/houses/create_house_model.dart';
import 'package:book_now/provider/check_data_provider.dart';
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
      final myCheckDataRead = context.read<CheckDataProvider>();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Create Houses",
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
                      controller: houseNameController,
                      label: 'House Name',
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
                      controller: floorNamberController,
                      label: 'Total floors',
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
                  SizedBox(
                    height: 15,
                  ),
                  myHousesWatch.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text("Create"),
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
                                  houseNameController.text =
                                      floorNamberController.text = "";
                                  myCheckDataRead.listenDataChange();
                                  await Flushbar(
                                    title: 'Success',
                                    message: "Added",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                } else {
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
