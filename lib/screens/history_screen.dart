import 'package:book_now/component/appBar_component.dart';
import 'package:book_now/component/date_time_picker.dart';
import 'package:book_now/component/menu/buildMenu.dart';
import 'package:book_now/provider/check_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatelessWidget {
  final _advancedDrawerController = AdvancedDrawerController();
  final scrollListView = ScrollController();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final myHistoryWatch = context.watch<CheckDataProvider>();
    final myHistoryRead = context.read<CheckDataProvider>();
    final query = MediaQuery.of(context).size;

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
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      "Filter Date",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 750,
                      child: Form(
                        key: formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              width: 600 * .2,
                              child: Text(
                                "From",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Container(
                              width: 610 * .3,
                              child: defaultDateTimePicker(
                                context: context,
                                controller: dateFromController,
                                validator: (val) {
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Container(
                              width: 600 * .2,
                              child: Text(
                                "To",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Container(
                              width: 610 * .3,
                              child: defaultDateTimePicker(
                                  context: context,
                                  controller: dateToController,
                                  validator: (val) {
                                    return null;
                                  }),
                            ),
                            IconButton(
                              icon: FaIcon(FontAwesomeIcons.filter),
                              onPressed: () {
                                formKey.currentState!.save();
                                if (dateFromController.text.isEmpty ||
                                    dateToController.text.isEmpty) {
                                  myHistoryRead.disableFilter();
                                  return;
                                }
                                DateTime from =
                                    DateTime.parse(dateFromController.text);
                                DateTime to =
                                    DateTime.parse(dateToController.text);
                                if (from.isAfter(DateTime.now()) ||
                                    to.isAfter(DateTime.now())) {
                                  myHistoryRead.disableFilter();
                                  return;
                                }
                                myHistoryRead.filterHistory(from, to);
                              },
                            ),
                            SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                      height: myHistoryWatch.loadNewHistoryData
                                          ? query.height * .53
                                          : query.height * .58,
                                      child: NotificationListener(
                                        child: ListView.separated(
                                          controller: scrollListView,
                                          shrinkWrap: true,
                                          itemCount: myHistoryWatch.filterd
                                              ? myHistoryWatch
                                                  .filterHistoryData.length
                                              : myHistoryWatch.history.length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              height: 40,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                      width: 700 * .3,
                                                      child: Center(
                                                          child: Text(myHistoryWatch
                                                                  .filterd
                                                              ? myHistoryWatch
                                                                  .filterHistoryData[
                                                                      index]
                                                                  .tableName
                                                              : myHistoryWatch
                                                                  .history[
                                                                      index]
                                                                  .tableName))),
                                                  Container(
                                                    width: 2,
                                                    color: Colors.grey,
                                                  ),
                                                  Container(
                                                    width: 700 * .2,
                                                    child: Center(
                                                      child: Text(myHistoryWatch
                                                              .filterd
                                                          ? myHistoryWatch
                                                              .filterHistoryData[
                                                                  index]
                                                              .action
                                                          : myHistoryWatch
                                                              .history[index]
                                                              .action),
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
                                                              .filterd
                                                          ? myHistoryWatch
                                                              .filterHistoryData[
                                                                  index]
                                                              .date
                                                          : myHistoryWatch
                                                              .history[index]
                                                              .date),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Divider(
                                              thickness: 2,
                                            );
                                          },
                                        ),
                                        onNotification: (dynamic scroll) {
                                          if (scroll is ScrollEndNotification) {
                                            if (myHistoryWatch.curPage !=
                                                myHistoryWatch.maxPage) {
                                              if (scrollListView.position
                                                      .maxScrollExtent ==
                                                  scroll.metrics.pixels) {
                                                myHistoryRead.getNexPage();
                                              }
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
                ],
              ),
            ),
            myHistoryWatch.loadNewHistoryData
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
