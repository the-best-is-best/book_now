import 'package:book_now/component/app_bar_component.dart';
import 'package:book_now/component/date_time_picker.dart';
import 'package:book_now/component/menu/build_menu.dart';
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

  HistoryScreen({Key? key}) : super(key: key);

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
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: buildMenu(4, context),
      child: Scaffold(
        appBar: buildAppBar("History", _advancedDrawerController),
        body: Column(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Filter Date",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 750,
                      child: Form(
                        key: formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(
                              width: 25,
                            ),
                            SizedBox(
                              width: 600 * .2,
                              child: Text(
                                "From",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            SizedBox(
                              width: 610 * .3,
                              child: defaultDateTimePicker(
                                context: context,
                                controller: dateFromController,
                                validator: (val) {
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                            SizedBox(
                              width: 600 * .2,
                              child: Text(
                                "To",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            SizedBox(
                              width: 610 * .3,
                              child: defaultDateTimePicker(
                                  context: context,
                                  controller: dateToController,
                                  validator: (val) {
                                    return null;
                                  }),
                            ),
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.filter),
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
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Card(
                    elevation: 20,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: 750,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 700 * .3,
                                        child: Center(
                                          child: Text(
                                            "Table Name",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 700 * .2,
                                        child: Center(
                                          child: Text(
                                            "Action",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 700 * .5,
                                        child: Center(
                                          child: Text(
                                            "Date",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    height: myHistoryWatch.loadNewHistoryData
                                        ? query.height *
                                            (query.height * .5 / 640)
                                        : query.height *
                                            (query.height * .58 / 640),
                                    child: NotificationListener(
                                      child: ListView.separated(
                                        controller: scrollListView,
                                        shrinkWrap: true,
                                        itemCount: myHistoryWatch.filterd
                                            ? myHistoryWatch
                                                .filterHistoryData.length
                                            : myHistoryWatch.history.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            height: 40,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                    width: 700 * .3,
                                                    child: Center(
                                                        child: Text(myHistoryWatch
                                                                .filterd
                                                            ? myHistoryWatch
                                                                .filterHistoryData[
                                                                    index]
                                                                .tableName
                                                            : myHistoryWatch
                                                                .history[index]
                                                                .tableName))),
                                                Container(
                                                  width: 2,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
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
                                                SizedBox(
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
                                            (BuildContext context, int index) {
                                          return const Divider(
                                            thickness: 2,
                                          );
                                        },
                                      ),
                                      onNotification: (dynamic scroll) {
                                        if (scroll is ScrollEndNotification &&
                                            myHistoryWatch.curPage !=
                                                myHistoryWatch.maxPage &&
                                            scrollListView
                                                    .position.maxScrollExtent ==
                                                scroll.metrics.pixels) {
                                          myHistoryRead.getNexPage();
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
                ],
              ),
            ),
            myHistoryWatch.loadNewHistoryData
                ? Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
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
