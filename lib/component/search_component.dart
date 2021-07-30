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
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Center(
          child: Text(
        "Search",
        style: Theme.of(context).textTheme.headline2,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: query.width * .75,
            child: defaultFormField(
              context: context,
              controller: searchController,
              label: '$searchTitle',
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
      SizedBox(
        height: 20,
      ),
    ],
  );
}
