import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/date_time_picker.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/create_project/create_project_model.dart';
import 'package:book_now/modals/create_project/projects_model.dart';
import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../reports_screen.dart';

Widget createProjectTab() {
  GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  return Builder(
    builder: (context) {
      final myProjectRead = context.read<MyProjectProvider>();
      final reportsRead = context.read<ReportsProvider>();
      final myProjectWatch = context.watch<MyProjectProvider>();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(
            "Create Project",
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
                      controller: projectNameController,
                      label: 'Project Name',
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
                  defaultDateTimePicker(
                      context: context,
                      controller: endDateController,
                      label: "End Date",
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
                                    houseName: houseNameController.text,
                                    endDate: endDateController.text);
                            myProjectRead
                                .createProjectClicked(createProjectModel)
                                .then(
                              (response) async {
                                var data = response.data;
                                if (response.statusCode == 201) {
                                  var project = data['data'];
                                  ProjectsModel projects =
                                      ProjectsModel.fromJson(project);
                                  myProjectRead.insertToList(projects);
                                  reportsRead.goToProject(projects);
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          duration: Duration(microseconds: 500),
                                          type: PageTransitionType.fade,
                                          child: ReportsScreen()));
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
          )
        ],
      );
    },
  );
}
