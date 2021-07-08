import 'package:book_now/provider/my_project_provider.dart';
import 'package:book_now/provider/reports_provider.dart';
import 'package:book_now/screens/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

Widget selectProjectTab() {
  return Column(
    children: [
      Builder(builder: (context) {
        final query = MediaQuery.of(context).size;
        final myProjectWatch = context.watch<MyProjectProvider>();
        final reportsRead = context.read<ReportsProvider>();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              "Select Project",
              style: Theme.of(context).textTheme.headline4,
            )),
            SizedBox(
              height: 5,
            ),
            Divider(
              thickness: 3,
            ),
            Center(
              child: Container(
                height: query.height - 229,
                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: myProjectWatch.myProject.length,
                  itemBuilder: (_, int index) => ElevatedButton(
                    onPressed: () {
                      reportsRead.goToProject(myProjectWatch.myProject[index]);
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              duration: Duration(microseconds: 500),
                              type: PageTransitionType.fade,
                              child: ReportsScreen()));
                    },
                    child: (Text(myProjectWatch.myProject[index].projectName)),
                  ),
                  staggeredTileBuilder: (int index) =>
                      StaggeredTile.count(1, 1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
              ),
              /*
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: myProjectWatch.myProject.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Container(
                        width: query.width,
                        child: ElevatedButton(
                          child:
                              Text(myProjectWatch.myProject[index].projectName),
                          onPressed: () {
                            reportsRead
                                .goToProject(myProjectWatch.myProject[index]);
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    duration: Duration(microseconds: 500),
                                    type: PageTransitionType.fade,
                                    child: ReportsScreen()));
                          },
                        )),
                  ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 2,
                  );
                },
                
              ),*/
            ),
          ],
        );
      }),
    ],
  );
}
