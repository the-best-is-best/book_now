import 'package:book_now/component/search_component.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/tabs/update/change_data_person.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget repManagementReportsTab() {
  final searchPeople = TextEditingController();
  final scrollListView = ScrollController();
  return Builder(
    builder: (context) {
      final myReportWatch = context.watch<ReportsProvider>();
      final myReportRead = context.read<ReportsProvider>();
      final query = MediaQuery.of(context).size;
      final padding = MediaQuery.of(context).padding;
      final height =
          query.height - padding.top - padding.bottom - kToolbarHeight;
      return Container(
        child: Center(
          child: Column(
            children: [
              Text(
                "Management",
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 5,
              ),
              Divider(
                thickness: 3,
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                child: Column(
                  children: [
                    Center(
                      child: myReportWatch.myRelPeople.length > 20
                          ? buildSearchComponent(
                              context: context,
                              searchController: searchPeople,
                              searchTitle: "People Name",
                              onSubmit: (val) {
                                myReportRead.searchInRelPeople(val);
                              })
                          : Container(),
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              width: query.width * .4,
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
                              width: query.width * .15,
                              child: Center(child: Text("paid up"))),
                          Container(
                              width: query.width * .15,
                              child: Center(child: Text("Support"))),
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
                      height: myReportWatch.myRelPeople.length > 20
                          ? myReportWatch.loadNewRelPeopleData
                              ? height * (height * .38 / 640)
                              : height * (height * .5 / 640)
                          : myReportWatch.loadNewRelPeopleData
                              ? height * (height * .63 / 640)
                              : height * (height * .8 / 640),
                      child: NotificationListener(
                        child: myReportWatch.loadingSearch
                            ? Center(child: CircularProgressIndicator())
                            : ListView.separated(
                                controller: scrollListView,
                                shrinkWrap: true,
                                itemCount: myReportWatch.searched
                                    ? myReportWatch.searchRelPeople.length
                                    : myReportWatch.relPeopleData.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 25,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            width: query.width * .4,
                                            child: Center(
                                                child: Text(myReportWatch
                                                        .searched
                                                    ? myReportWatch
                                                        .searchRelPeople[index]
                                                        .peopleName
                                                    : myReportWatch
                                                        .relPeopleData[index]
                                                        .peopleName))),
                                        Container(
                                          width: 2,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          width: query.width * .15,
                                          child: Center(
                                            child: Text(myReportWatch.searched
                                                ? myReportWatch
                                                    .searchRelPeople[index].paid
                                                    .toString()
                                                : myReportWatch
                                                    .relPeopleData[index].paid
                                                    .toString()),
                                          ),
                                        ),
                                        Container(
                                          width: 2,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          width: query.width * .15,
                                          child: Center(
                                            child: Text(myReportWatch.searched
                                                ? myReportWatch
                                                    .searchRelPeople[index]
                                                    .support
                                                    .toString()
                                                : myReportWatch
                                                    .relPeopleData[index]
                                                    .support
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
                                                myReportRead
                                                    .searchInRelPeople("");
                                                Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        duration: Duration(
                                                            microseconds: 500),
                                                        type: PageTransitionType
                                                            .fade,
                                                        child: ChangeDataPerson(
                                                            myReportWatch
                                                                    .searched
                                                                ? myReportWatch
                                                                        .searchRelPeople[
                                                                    index]
                                                                : myReportWatch
                                                                        .relPeopleData[
                                                                    index],
                                                            RoomsModel(
                                                                id: 0,
                                                                bunkBed: 0,
                                                                name: 0,
                                                                floor: 0,
                                                                houseId: 0,
                                                                numbersOfBed:
                                                                    0))));
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Divider(
                                    thickness: 2,
                                  );
                                }),
                      ),
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
