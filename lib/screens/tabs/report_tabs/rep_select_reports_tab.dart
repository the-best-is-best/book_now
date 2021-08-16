import 'package:book_now/component/search_component.dart';
import 'package:book_now/modals/rooms/rooms_model.dart';
import 'package:book_now/modals/travel/travel_model.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/provider/travel_provider.dart';
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

      final travelWatch = context.watch<TravelProvider>();
      return Container(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: myReportWatch.indexManagment == 0
                          ? null
                          : () {
                              myReportRead.changeindexManagment(0);
                            },
                      icon: Icon(
                        Icons.arrow_left_rounded,
                        size: 40,
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Management",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: myReportWatch.indexManagment == 1
                          ? null
                          : () {
                              myReportRead.changeindexManagment(1);
                            },
                      icon: Icon(
                        Icons.arrow_right_rounded,
                        size: 40,
                      )),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Divider(
                thickness: 3,
              ),
              Container(
                  padding: EdgeInsets.only(top: 5),
                  child: myReportWatch.indexManagment == 0
                      ? peopleData(
                          myReportWatch,
                          context,
                          searchPeople,
                          myReportRead,
                          query,
                          height,
                          scrollListView,
                          travelWatch)
                      : getDataManagment(
                          query, height, context, travelWatch, myReportWatch)),
            ],
          ),
        ),
      );
    },
  );
}

Container getDataManagment(Size query, double height, BuildContext context,
    TravelProvider travelWatch, ReportsProvider myReportWatch) {
  return Container(
    width: query.width * 2 / 3,
    height: height * .57,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Row(children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Number of subscribers",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  for (TravelModel travelData in travelWatch.myTravel) ...{
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Transport ${travelData.name}",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  }
                ],
              ),
            ),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text(
                    myReportWatch.relPeopleData.length.toString(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  for (TravelModel travelData in travelWatch.myTravel) ...{
                    Text(
                      myReportWatch.travelPlaceCount[travelData.id].toString(),
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  }
                ],
              ),
            ),
          ]),
          Divider(
            thickness: 3,
          ),
          Row(children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "The total amount",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Total payments",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Total support",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Remaining ",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Coupons received",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Coupons not received",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text(
                    (myReportWatch.myProject!.price *
                            myReportWatch.relPeopleData.length)
                        .toString(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    myReportWatch.totalPayments.toString(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    myReportWatch.supportPayment.toString(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    (myReportWatch.myProject!.price *
                                myReportWatch.relPeopleData.length -
                            myReportWatch.totalPayments -
                            myReportWatch.supportPayment)
                        .toString(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    myReportWatch.couponReceived.toString(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    (myReportWatch.relPeopleData.length -
                            myReportWatch.couponReceived)
                        .toString(),
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    ),
  );
}

Widget peopleData(
    ReportsProvider myReportWatch,
    BuildContext context,
    TextEditingController searchPeople,
    ReportsProvider myReportRead,
    Size query,
    double height,
    ScrollController scrollListView,
    TravelProvider travelWatch) {
  return Column(
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
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: 1000,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: 1000 * .3,
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
                      width: query.width * .1,
                      child: Center(child: Text("Travel"))),
                  Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                  Container(
                      width: query.width * .12,
                      child: Center(child: Text("paid up"))),
                  Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                  Container(
                      width: query.width * .12,
                      child: Center(child: Text("Support"))),
                  Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                  Container(
                      width: query.width * .12,
                      child: Center(child: Text("coupons"))),
                  Container(
                    width: 2,
                    color: Colors.grey,
                  ),
                  Container(
                      width: query.width * .2,
                      child: Center(child: Text("Change"))),
                ],
              ),
              Column(
                children: [
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
                            ? height * (height * .36 / 640)
                            : height * (height * .48 / 640)
                        : myReportWatch.loadNewRelPeopleData
                            ? height * (height * .61 / 640)
                            : height * (height * .78 / 640),
                    width: 1000,
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
                                final int people = myReportWatch.searched
                                    ? myReportWatch
                                        .searchRelPeople[index].travelId
                                    : myReportWatch
                                        .relPeopleData[index].travelId;
                                String travelName = travelWatch.myTravel
                                    .firstWhere((travel) => travel.id == people)
                                    .name;
                                return Container(
                                  height: 25,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          width: query.width * .3,
                                          child: Center(
                                              child: Text(myReportWatch.searched
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
                                          width: query.width * .1,
                                          child:
                                              Center(child: Text(travelName))),
                                      Container(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        width: query.width * .12,
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
                                        width: query.width * .12,
                                        child: Center(
                                          child: Text(myReportWatch.searched
                                              ? myReportWatch
                                                  .searchRelPeople[index]
                                                  .support
                                                  .toString()
                                              : myReportWatch
                                                  .relPeopleData[index].support
                                                  .toString()),
                                        ),
                                      ),
                                      Container(
                                        width: 2,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        width: query.width * .12,
                                        child: Center(
                                          child: Text(myReportWatch.searched
                                              ? myReportWatch
                                                  .searchRelPeople[index].bones
                                                  .toString()
                                              : myReportWatch
                                                  .relPeopleData[index].bones
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
                                                          myReportWatch.searched
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
            ],
          ),
        ),
      ),
    ],
  );
}
