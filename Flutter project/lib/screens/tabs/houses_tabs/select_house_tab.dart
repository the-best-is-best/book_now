import 'package:book_now/component/search_component.dart';
import 'package:book_now/provider/houses_provider.dart';
import 'package:book_now/screens/expanded/floors_expanded.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget selectHousesTab() {
  final searchControllerController = TextEditingController();
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
                    searchController: searchControllerController,
                    searchTitle: "house name",
                    onSubmit: (String? val) {
                      myHousesRead.searchHouse(val!);
                    },
                  )
                : Container(),
            Center(
                child: Text(
              "Select Houses",
              style: Theme.of(context).textTheme.headline1,
            )),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 3,
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: searchControllerController.text.isEmpty
                  ? myHousesWatch.myHouses.isNotEmpty
                      ? buildListView(
                          myHousesWatch: myHousesWatch,
                          query: query,
                          searchControllerController:
                              searchControllerController,
                        )
                      : Center(
                          child: Text(
                            "No houses",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        )
                  : myHousesWatch.searchMyHouse.isNotEmpty
                      ? buildListView(
                          searchControllerController:
                              searchControllerController,
                          myHousesWatch: myHousesWatch,
                          query: query,
                        )
                      : Center(
                          child: Text(
                            "No Houses",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ),
            ),
          ],
        );
      }),
    ],
  );
}

ListView buildListView({
  required TextEditingController searchControllerController,
  required HousesProvider myHousesWatch,
  required Size query,
}) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: searchControllerController.text.isEmpty
        ? myHousesWatch.myHouses.length
        : myHousesWatch.searchMyHouse.length,
    itemBuilder: (BuildContext context, int index) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: myHousesWatch.loadingSearch
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: query.width,
                  child: ExpandableNotifier(
                    child: ScrollOnExpand(
                      child: ExpandablePanel(
                        header: searchControllerController.text.isEmpty
                            ? Text(
                                "$index - ${myHousesWatch.myHouses[index].name}",
                                style: Theme.of(context).textTheme.headline3,
                              )
                            : Text(
                                "$index - ${myHousesWatch.searchMyHouse[index].name}",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                        collapsed: Container(),
                        expanded: Container(
                          child: searchControllerController.text.isEmpty
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
      return const Divider(
        thickness: 2,
      );
    },
  );
}
