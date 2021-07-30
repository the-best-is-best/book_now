import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/date_time_picker.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/create_project/create_project_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget createProjectTab() {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  return Builder(
    builder: (context) {
      final myProjectRead = context.read<MyProjectProvider>();
      final myProjectWatch = context.watch<MyProjectProvider>();
      final myHousesWatch = context.watch<HousesProvider>();

      endDateController.text = DateTime.now().toIso8601String();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Create Project",
            style: Theme.of(context).textTheme.headline1,
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
                      controller: projectNameController,
                      label: 'Project Name *',
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonFormField<int?>(
                        icon: null,
                        hint: Text('Select House *'),
                        value: myProjectWatch.houseSelected,
                        items: myHousesWatch.myHouses
                            .map((house) => DropdownMenuItem(
                                  value: house.id,
                                  child: Text(
                                    house.name,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          myProjectRead.changeHouseSelected(value);
                        },
                        validator: (int? val) {
                          if (val == null || val == 0) {
                            return "select house plz";
                          }
                        }),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultFormField(
                      context: context,
                      controller: priceController,
                      label: 'Price *',
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
                  defaultDateTimePicker(
                      context: context,
                      controller: endDateController,
                      label: "End Date *",
                      validator: (String? val) {
                        if (val == null ||
                            val.isEmpty ||
                            DateTime.parse(val).isBefore(DateTime.now())) {
                          return "Date is not correct";
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 15,
                  ),
                  myProjectWatch.loading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          child: Text("Create"),
                          onPressed: () {
                            _keyForm.currentState!.save();
                            if (!_keyForm.currentState!.validate()) {
                              return;
                            }
                            CreateProjectModel createProjectModel =
                                CreateProjectModel(
                                    projectName: projectNameController.text,
                                    price: int.parse(priceController.text),
                                    houseId: myProjectWatch.houseSelected!,
                                    endDate: endDateController.text);
                            myProjectRead
                                .createProjectClicked(createProjectModel)
                                .then(
                              (response) async {
                                var data = response.data;
                                if (data['messages'][0] == "Project Created") {
                                  DioHelper.postNotification().then((_) =>
                                      myProjectRead
                                          .loadingEnd()
                                          .then((_) async {
                                        projectNameController.text =
                                            priceController.text = "";
                                        endDateController.text =
                                            DateTime.now().toIso8601String();
                                        myProjectRead.changeHouseSelected(null);
                                        await Flushbar(
                                          title: 'Success',
                                          message: "Added",
                                          duration: Duration(seconds: 3),
                                        ).show(context);
                                      }));
                                } else {
                                  myProjectRead.loadingEnd().then((_) async {
                                    List<dynamic> messages = data['messages'];
                                    for (int i = 0; i < messages.length; i++) {
                                      await Flushbar(
                                        title: 'Error',
                                        message: messages[i],
                                        duration: Duration(seconds: 3),
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
          )
        ],
      );
    },
  );
}
