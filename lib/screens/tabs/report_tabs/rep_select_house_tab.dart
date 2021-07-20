import 'package:another_flushbar/flushbar.dart';
import 'package:book_now/modals/rel/rel_houses_model.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/provider/rel/rel_houses_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class RepSelectHouseTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myRelHousesRead = context.read<RelHousesProvider>();
    final myRelHousesWatch = context.watch<RelHousesProvider>();

    final myReportWatch = context.watch<ReportsProvider>();

    final myHousesWatch = context.watch<HousesProvider>();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Choose the house",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 3,
              ),
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: myHousesWatch.myHouses.length,
                            itemBuilder: (context, index) {
                              RelHousesModel curRelHouse = myRelHousesWatch
                                  .relHouses
                                  .firstWhere((relHouse) {
                                return relHouse.houseId ==
                                        myHousesWatch.myHouses[index].id &&
                                    relHouse.projectId ==
                                        myReportWatch.myProject;
                              },
                                      orElse: () => RelHousesModel(
                                          id: 0,
                                          houseId:
                                              myHousesWatch.myHouses[index].id,
                                          active: false,
                                          projectId: myReportWatch.myProject));

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RoundCheckBox(
                                      isChecked: curRelHouse.active,
                                      onTap: (selected) {
                                        myRelHousesRead.checkOrUnChec(
                                            house: myHousesWatch
                                                .myHouses[index].id,
                                            checked: selected!,
                                            project: myReportWatch.myProject);
                                      },
                                      size: 30,
                                      uncheckedColor: mainColor,
                                      checkedColor: secColor,
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Text(
                                      myHousesWatch.myHouses[index].name,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    myRelHousesWatch.loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              myRelHousesRead
                                  .insertOrUpdateRelHouses()
                                  .then((val) async {
                                print(val);
                                if (val == true) {
                                  await Flushbar(
                                    title: 'Sucess',
                                    message: "Updated",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                }
                              });
                            },
                            child: Text("add"),
                          ),
                    SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
