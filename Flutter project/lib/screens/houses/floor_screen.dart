import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/network/dio_helper.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloorRoom extends StatelessWidget {
  final HouseModel myHouse;

  const FloorRoom({required this.myHouse, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myHousesRead = context.read<HousesProvider>();
    final myHousesWatch = context.watch<HousesProvider>();
    final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
    final TextEditingController newFloorNamberController =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Floor - ${myHouse.name}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Add Floor",
                    style: Theme.of(context).textTheme.headline4,
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
                              controller: newFloorNamberController,
                              label: 'Add new floors',
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
                                  child: const Text("Add"),
                                  onPressed: () {
                                    _keyForm.currentState!.save();
                                    if (!_keyForm.currentState!.validate()) {
                                      return;
                                    }
                                    _keyForm.currentState!.save();

                                    myHousesRead
                                        .updateFloor(
                                            myHouse.id,
                                            int.parse(
                                                newFloorNamberController.text))
                                        .then(
                                      (response) async {
                                        var data = response.data;
                                        if (data['messages'][0] ==
                                            "Floor updated") {
                                          DioHelper.postNotification().then(
                                              (_) => myHousesRead
                                                      .loadingEnd()
                                                      .then((_) async {
                                                    newFloorNamberController
                                                        .text = "";

                                                    Navigator.pop(context);

                                                    await Flushbar(
                                                      title: 'Success',
                                                      message: "Added",
                                                      duration: const Duration(
                                                          seconds: 3),
                                                    ).show(context);
                                                  }));
                                        } else {
                                          myHousesRead
                                              .loadingEnd()
                                              .then((_) async {
                                            List<dynamic> messages =
                                                data['messages'];
                                            for (int i = 0;
                                                i < messages.length;
                                                i++) {
                                              await Flushbar(
                                                title: 'Error',
                                                message: messages[i],
                                                duration:
                                                    const Duration(seconds: 3),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
