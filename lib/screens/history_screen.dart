import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/component/menu/buildMenu.dart';
import 'package:book_now/listen_data/listen_data.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    final myHistoryWatch = context.watch<CheckDataProvider>();
    final query = MediaQuery.of(context).size;

    return getDataFromServer(
      context: context,
      child: AdvancedDrawer(
        openRatio: .75,
        backdropColor: Colors.blueGrey,
        controller: _advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        childDecoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        drawer: buildMenu(4, context),
        child: Scaffold(
          appBar: buildAppBar("History", _advancedDrawerController),
          body: Center(
            child: Container(
              child: Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: query.width > 750
                        ? Container(
                            width: 750,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Table Name",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                      "Action",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    Text(
                                      "Date",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: query.height * 3 / 4,
                                  width: 750,
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  ...myHistoryWatch.lisenData
                                                      .map(
                                                        (item) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            item.tableName,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  SizedBox(
                                                    height: 50,
                                                    width: 150,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  ...myHistoryWatch.lisenData
                                                      .map(
                                                        (item) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            item.action,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  SizedBox(
                                                    height: 50,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  ...myHistoryWatch.lisenData
                                                      .map(
                                                        (item) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            item.date,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  SizedBox(
                                                    height: 50,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                width: 750,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          "Table Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Text(
                                          "Action",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Text(
                                          "Date",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                      height: query.height * 3 / 4,
                                      child: ListView(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  ...myHistoryWatch.lisenData
                                                      .map(
                                                        (item) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            item.tableName,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  SizedBox(
                                                    height: 50,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  ...myHistoryWatch.lisenData
                                                      .map(
                                                        (item) => Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 200),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                            child: Text(
                                                              item.action,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline6,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  SizedBox(
                                                    height: 50,
                                                  )
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  ...myHistoryWatch.lisenData
                                                      .map(
                                                        (item) => Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          child: Text(
                                                            item.date,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline6,
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                                  SizedBox(
                                                    height: 50,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
