import 'package:book_now/provider/reports_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RepSelectResidenceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myReportWatch = context.watch<ReportsProvider>();
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
            Row(
              children: [],
            ),
            SingleChildScrollView(
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: myReportWatch.myRelPeople.length,
                  itemBuilder: (context, index) => Container(
                        width: 750,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                "Paid : ${myReportWatch.myRelPeople[index].paid}"),
                            Container(
                              width: 2,
                              height: 10,
                              color: Colors.grey,
                            ),
                            Text(
                                "Support : ${myReportWatch.myRelPeople[index].support}")
                          ],
                        ),
                      ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 2,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
