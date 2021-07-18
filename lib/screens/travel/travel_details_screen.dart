import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/component/form_field.dart';
import 'package:book_now/modals/travel/travel_model.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TravelDetailsScreen extends StatefulWidget {
  final TravelModel travel;

  TravelDetailsScreen({required this.travel});

  @override
  _TravelDetailsScreenState createState() => _TravelDetailsScreenState();
}

class _TravelDetailsScreenState extends State<TravelDetailsScreen> {
  final _keyForm = GlobalKey<FormState>();

  final newNameTravelController = TextEditingController();

  bool firstload = false;
  @override
  void initState() {
    if (!firstload) {
      newNameTravelController.text = widget.travel.name;
      firstload = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myCheckDataRead = context.read<CheckDataProvider>();

    final myTravelRead = context.read<TravelProvider>();
    final myTravelWatch = context.watch<TravelProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit travel"),
        actions: [
          IconButton(
            icon: myTravelWatch.editTravelActive
                ? FaIcon(FontAwesomeIcons.eye)
                : FaIcon(FontAwesomeIcons.edit),
            onPressed: () {
              myTravelRead.inEdit();
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              child: Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      myTravelWatch.editTravelActive
                          ? Column(
                              children: [
                                Form(
                                  key: _keyForm,
                                  child: defaultFormField(
                                      context: context,
                                      controller: newNameTravelController,
                                      label: 'New Name',
                                      type: TextInputType.number,
                                      validate: (String? val) {
                                        if (val != null && val.isEmpty ||
                                            val != null &&
                                                val.isEmpty &&
                                                val.length < 3) {
                                          return "min 3 characters";
                                        }
                                        return null;
                                      }),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                myTravelWatch.loading
                                    ? CircularProgressIndicator()
                                    : ElevatedButton(
                                        child: Text("Edit"),
                                        onPressed: () {
                                          _keyForm.currentState!.save();
                                          if (!_keyForm.currentState!
                                              .validate()) {
                                            return;
                                          }
                                          _keyForm.currentState!.save();

                                          myTravelRead
                                              .updateTravel(
                                            id: widget.travel.id,
                                            name: newNameTravelController.text,
                                          )
                                              .then(
                                            (response) async {
                                              var data = response.data;
                                              if (data['messages'][0] ==
                                                  "Travel updated") {
                                                newNameTravelController.text =
                                                    "";
                                                myCheckDataRead
                                                    .listenDataChange();

                                                Navigator.pop(context);
                                                await Flushbar(
                                                  title: 'Success',
                                                  message: "Updated",
                                                  duration:
                                                      Duration(seconds: 3),
                                                ).show(context);
                                              } else {
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
                            )
                          : Text(
                              "Name : ${widget.travel.name}",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
