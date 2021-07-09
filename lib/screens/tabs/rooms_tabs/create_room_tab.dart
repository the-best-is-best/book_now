import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/houses/create_house_model.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget createRoomTab() {
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
                  myHousesWatch.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text("Create"),
                          onPressed: () {
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
                                    ));
                            myHousesRead
                                .createHouseClicked(createHouseModel)
                                .then(
                              (response) async {
                                var data = response.data;
                                if (response.statusCode == 201) {
                                  var project = data['data'];
                                  HouseModel projects =
                                      HouseModel.fromJson(project);
                                  myHousesRead.insertToList(projects);
                                  houseNameController.text = "";

                                  await Flushbar(
                                    title: 'Success',
                                    message: "Added",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                } else {
                                  myHousesRead.insertFiled();
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
          )
        ],
      );
    },
  );
}
