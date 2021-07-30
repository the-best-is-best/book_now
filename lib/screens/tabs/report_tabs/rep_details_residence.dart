import 'package:book_now/component/search_component.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/change_room_residence.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget repDetailsResidenceTab() {
  final searchPeople = TextEditingController();
  return Builder(
    builder: (context) {
      final query = MediaQuery.of(context).size;
      final myReportWatch = context.watch<ReportsProvider>();
      return Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Residence",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Center(
                      child: buildSearchComponent(
                          context: context,
                          searchController: searchPeople,
                          searchTitle: "People Name",
                          onSubmit: (val) {}),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: query.width * .5,
                              child: Center(
                                  child: Text(
                                "Name",
                                overflow: TextOverflow.fade,
                              ))),
                          Container(
                            width: 2,
                            color: Colors.grey,
                          ),
                          Container(
                              width: query.width * .2,
                              child: Center(child: Text("Room"))),
                          Container(
                            width: 2,
                            color: Colors.grey,
                          ),
                          Container(
                              width: query.width * .2,
                              child: Center(child: Text("Change"))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: query.height * .43,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: myReportWatch.myRelPeople.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 25,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      width: query.width * .5,
                                      child: Center(
                                          child: Text(myReportWatch
                                              .myRelPeople[index].peopleName))),
                                  Container(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: query.width * .2,
                                    child: Center(
                                      child: Text(myReportWatch
                                          .myRelPeople[index].roomId
                                          .toString()),
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    width: query.width * .2,
                                    child: Center(
                                      child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(Icons.change_circle),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  duration: Duration(
                                                      microseconds: 500),
                                                  type: PageTransitionType.fade,
                                                  child: ChangeRoomResidence(
                                                      myReportWatch
                                                          .myRelPeople[index]
                                                          .id)));
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              thickness: 2,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
