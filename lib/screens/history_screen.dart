import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/component/menu/buildMenu.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  final _advancedDrawerController = AdvancedDrawerController();
  final scrollListView = ScrollController();

  @override
  Widget build(BuildContext context) {
    final myHistoryWatch = context.watch<CheckDataProvider>();
    final myHistoryRead = context.read<CheckDataProvider>();
    final query = MediaQuery.of(context).size;
    //final widthGrid = query.width * 4 / 320;
    //  final itemRowCount = widthGrid.toInt();
    return AdvancedDrawer(
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
        body: Column(
          children: [
            Center(
              child: Container(
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            width: 750,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 700 * .3,
                                      child: Center(
                                        child: Text(
                                          "Table Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 700 * .2,
                                      child: Center(
                                        child: Text(
                                          "Action",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 700 * .5,
                                      child: Center(
                                        child: Text(
                                          "Date",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  width: 750,
                                  height: myHistoryWatch.getHistoryData
                                      ? query.height * .6
                                      : query.height * .75,
                                  child: NotificationListener(
                                    child: ListView.separated(
                                      controller: scrollListView,
                                      shrinkWrap: true,
                                      itemCount: myHistoryWatch.history.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 40,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                  width: 700 * .3,
                                                  child: Center(
                                                      child: Text(myHistoryWatch
                                                          .history[index]
                                                          .tableName))),
                                              Container(
                                                width: 2,
                                                color: Colors.grey,
                                              ),
                                              Container(
                                                width: 700 * .2,
                                                child: Center(
                                                  child: Text(myHistoryWatch
                                                      .history[index].action
                                                      .toString()),
                                                ),
                                              ),
                                              Container(
                                                width: 2,
                                                color: Colors.grey,
                                              ),
                                              Container(
                                                width: 700 * .5,
                                                child: Center(
                                                  child: Text(myHistoryWatch
                                                      .history[index].date
                                                      .toString()),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Divider(
                                          thickness: 2,
                                        );
                                      },
                                    ),
                                    onNotification: (dynamic scroll) {
                                      if (scroll is ScrollEndNotification) {
                                        if (scrollListView
                                                .position.maxScrollExtent ==
                                            scroll.metrics.pixels) {
                                          print("end Scroll");
                                          myHistoryRead.getNexPage();
                                        }
                                      }
                                      return true;
                                    },
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
            myHistoryWatch.getHistoryData
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
