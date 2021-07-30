import 'package:book_now/component/search_component.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/change_room_residence.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget repDetailsResidenceTab() {
  final searchPeople = TextEditingController();
  final scrollListView = ScrollController();
  return Builder(
    builder: (context) {
      final query = MediaQuery.of(context).size;
      final myReportWatch = context.watch<ReportsProvider>();
      final myReportRead = context.read<ReportsProvider>();
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
                          onSubmit: (val) {
                            myReportRead.searchInRelPeople(val);
                          }),
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
                      height: myReportWatch.loadNewRelPeopleData
                          ? query.height * (query.height * .35 / 640)
                          : query.height * (query.height * .43 / 640),
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
                                            width: query.width * .5,
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
                                          width: query.width * .2,
                                          child: Center(
                                            child: Text(myReportWatch.searched
                                                ? myReportWatch
                                                    .searchRelPeople[index]
                                                    .roomId
                                                    .toString()
                                                : myReportWatch
                                                    .relPeopleData[index].roomId
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
                                                        type: PageTransitionType
                                                            .fade,
                                                        child:
                                                            ChangeRoomResidence(
                                                                myReportWatch
                                                                    .myRelPeople[
                                                                        index]
                                                                    .id)));
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
                        onNotification: (dynamic scroll) {
                          if (myReportWatch.curPage != myReportWatch.maxPage) {
                            if (scrollListView.position.maxScrollExtent ==
                                scroll.metrics.pixels) {
                              myReportWatch.getNexPage();
                            }
                          }

                          return true;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              myReportWatch.loadNewRelPeopleData
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
    },
  );
}
