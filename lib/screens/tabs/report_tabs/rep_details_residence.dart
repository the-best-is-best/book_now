import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget repDetailsResidenceTab() {
  return Builder(
    builder: (context) {
      final query = MediaQuery.of(context).size;
      final myReportWatch = context.watch<ReportsProvider>();
      final myPeople = context.watch<PeopleProvider>();
      return Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Residence",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: query.width * .5,
                              child: Center(child: Text("Name"))),
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
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        itemCount: myReportWatch.myRelPeople.length,
                        itemBuilder: (context, index) {
                          String peopleName = myPeople.myPeople
                              .firstWhere((people) =>
                                  people.id ==
                                  myReportWatch.myRelPeople[index].id)
                              .name;
                          return Container(
                            height: 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                    width: query.width * .5,
                                    child: Center(child: Text(peopleName))),
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
                                      onPressed: () {},
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
