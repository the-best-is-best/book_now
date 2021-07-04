import 'package:book_now/component/form_field.dart';
import 'package:flutter/material.dart';

Widget createProjectTab() {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController houseNameController = TextEditingController();

  return Builder(
    builder: (context) => Column(
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
            child: Column(
              children: [
                defaultFormField(
                    context: context,
                    controller: projectNameController,
                    label: 'Project Name',
                    type: TextInputType.text,
                    validate: (String? val) {}),
                SizedBox(
                  height: 15,
                ),
                defaultFormField(
                    context: context,
                    controller: houseNameController,
                    label: 'House Name',
                    type: TextInputType.text,
                    validate: (String? val) {}),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  child: Text("Create"),
                  onPressed: () {},
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}
