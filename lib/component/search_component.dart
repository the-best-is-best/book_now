import 'package:book_now/component/form_field.dart';
import 'package:flutter/material.dart';

Widget buildSearchComponent({
  required BuildContext context,
  required TextEditingController searchController,
  required String searchTitle,
  required onSubmit,
}) {
  final query = MediaQuery.of(context).size;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
          child: Text(
        "Search",
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
      Row(
        children: [
          Container(
            width: query.width * .7,
            child: defaultFormField(
              context: context,
              controller: searchController,
              label: 'Search $searchTitle',
              type: TextInputType.text,
              suffix: Icons.search,
              validate: (String? val) {
                return null;
              },
              onSubmit: onSubmit,
            ),
          ),
        ],
      ),
    ],
  );
}
