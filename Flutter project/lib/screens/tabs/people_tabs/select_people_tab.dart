import 'package:book_now/component/search_component.dart';
import 'package:book_now/provider/people_provider.dart';
import 'package:book_now/screens/people/people_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget selectPeopleTab() {
  final searchPeopleController = TextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Builder(builder: (context) {
        final query = MediaQuery.of(context).size;
        final myPeopleRead = context.read<PeopleProvider>();

        final myPeopleWatch = context.watch<PeopleProvider>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myPeopleWatch.myPeople.length > 20
                ? buildSearchComponent(
                    context: context,
                    searchController: searchPeopleController,
                    searchTitle: "people name",
                    onSubmit: (String? val) {
                      myPeopleRead.searchPeople(val!);
                    },
                  )
                : Container(),
            Center(
                child: Text(
              "Select People",
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
            searchPeopleController.text.isEmpty
                ? myPeopleWatch.myPeople.isNotEmpty
                    ? buildListView(
                        myPeopleWatch: myPeopleWatch,
                        query: query,
                        searchPeopleController: searchPeopleController,
                      )
                    : Center(
                        child: Text(
                          "No people",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      )
                : myPeopleWatch.searchMypeople.isNotEmpty
                    ? buildListView(
                        searchPeopleController: searchPeopleController,
                        myPeopleWatch: myPeopleWatch,
                        query: query,
                      )
                    : Center(
                        child: Text(
                          "No people",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
          ],
        );
      }),
    ],
  );
}

ListView buildListView({
  required TextEditingController searchPeopleController,
  required PeopleProvider myPeopleWatch,
  required Size query,
}) {
  return ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: searchPeopleController.text.isEmpty
        ? myPeopleWatch.myPeople.length
        : myPeopleWatch.searchMypeople.length,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: myPeopleWatch.loadingSearch
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: query.width,
                child: searchPeopleController.text.isEmpty
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: const Duration(microseconds: 500),
                                  type: PageTransitionType.fade,
                                  child: PeopleDetailsScreen(
                                      people: myPeopleWatch.myPeople[index])));
                        },
                        child: Text(myPeopleWatch.myPeople[index].name),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  duration: const Duration(microseconds: 500),
                                  type: PageTransitionType.fade,
                                  child: PeopleDetailsScreen(
                                      people: myPeopleWatch
                                          .searchMypeople[index])));
                        },
                        child: Text(myPeopleWatch.searchMypeople[index].name),
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
