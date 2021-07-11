import 'package:book_now/component/search_component.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/screens/expanded/floors_expanded.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget selectHousesTab() {
  final searchHouseController = TextEditingController();
  return Column(
    children: [
      Builder(builder: (context) {
        final query = MediaQuery.of(context).size;
        final myHousesRead = context.read<HousesProvider>();

        final myHousesWatch = context.watch<HousesProvider>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myHousesWatch.myHouses.length > 20
                ? buildSearchComponent(
                    context: context,
                    searchHouse: searchHouseController,
                    myHousesRead: myHousesRead,
                    searchTitle: "house name",
                    onSubmit: (String? val) {
                      myHousesRead.searchHouse(val!);
                    },
                  )
                : Container(),
            Center(
                child: Text(
              "Select Houses",
              style: Theme.of(context).textTheme.headline4,
            )),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 3,
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: searchHouseController.text.isEmpty
                  ? myHousesWatch.myHouses.length > 0
                      ? buildListView(
                          myHousesWatch: myHousesWatch,
                          query: query,
                          searchHouseController: searchHouseController,
                        )
                      : Center(
                          child: Text(
                            "No houses",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        )
                  : myHousesWatch.searchMyHouse.length > 0
                      ? buildListView(
                          searchHouseController: searchHouseController,
                          myHousesWatch: myHousesWatch,
                          query: query,
                        )
                      : Center(
                          child: Text("No Houses"),
                        ),
            ),
          ],
        );
      }),
    ],
  );
}

ListView buildListView({
  required TextEditingController searchHouseController,
  required HousesProvider myHousesWatch,
  required Size query,
}) {
  return ListView.separated(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: searchHouseController.text.isEmpty
        ? myHousesWatch.myHouses.length
        : myHousesWatch.searchMyHouse.length,
    itemBuilder: (BuildContext context, int index) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: myHousesWatch.loadingSearch
              ? CircularProgressIndicator()
              : Container(
                  width: query.width,
                  child: ExpandableNotifier(
                    child: ScrollOnExpand(
                      child: ExpandablePanel(
                        header: Center(
                          child: searchHouseController.text.isEmpty
                              ? Text(
                                  "$index - ${myHousesWatch.myHouses[index].name}",
                                  style: Theme.of(context).textTheme.headline6,
                                )
                              : Text(
                                  "$index - ${myHousesWatch.searchMyHouse[index].name}",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                        ),
                        collapsed: Container(),
                        expanded: Container(
                          child: searchHouseController.text.isEmpty
                              ? buildFloorsExpanded(
                                  myHouses: myHousesWatch.myHouses[index],
                                  context: context,
                                  index: index,
                                )
                              : buildFloorsExpanded(
                                  myHouses: myHousesWatch.searchMyHouse[index],
                                  context: context,
                                  index: index,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider(
        thickness: 2,
      );
    },
  );
}
