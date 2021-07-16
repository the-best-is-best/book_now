import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/houses/house_model.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/floor_provider.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloorRoom extends StatelessWidget {
  final HouseModel myHouse;

  const FloorRoom({required this.myHouse});
  @override
  Widget build(BuildContext context) {
    final myCheckDataRead = context.read<CheckDataProvider>();
    final myHousesRead = context.read<HousesProvider>();
    final myHousesWatch = context.watch<HousesProvider>();
    final myFloorRead = context.read<FloorProvider>();
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
          Container(
            child: Card(
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
                                controller: newFloorNamberController,
                                label: 'Add new floors',
                                type: TextInputType.number,
                                validate: (String? val) {
                                  if (val == null || val.isEmpty) {
                                    return "empty !!";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            myHousesWatch.loading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    child: Text("Add"),
                                    onPressed: () {
                                      _keyForm.currentState!.save();
                                      if (!_keyForm.currentState!.validate()) {
                                        return;
                                      }
                                      _keyForm.currentState!.save();

                                      myHousesRead
                                          .updateFloor(
                                              myHouse.id,
                                              int.parse(newFloorNamberController
                                                  .text))
                                          .then(
                                        (response) async {
                                          var data = response.data;
                                          if (data['messages'][0] ==
                                              "Floor updated") {
                                            newFloorNamberController.text = "";
                                            /*  myFloorRead.getFloors(
                                                myHousesWatch.myHouses);*/
                                            /*   myCheckDataRead
                                                .listenToGetNewData();*/
                                            myCheckDataRead.listenDataChange();
                                            Navigator.pop(context);

                                            await Flushbar(
                                              title: 'Success',
                                              message: "Added",
                                              duration: Duration(seconds: 3),
                                            ).show(context);
                                          } else {
                                            //  myHousesRead.insertFiled();
                                            if (data['statusCode'] >= 400 &&
                                                data['success'] == false) {
                                              List<dynamic> messages =
                                                  data['messages'];
                                              for (int i = 0;
                                                  i < messages.length;
                                                  i++) {
                                                await Flushbar(
                                                  title: 'Error',
                                                  message: messages[i],
                                                  duration:
                                                      Duration(seconds: 3),
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
