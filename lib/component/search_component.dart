import 'package:book_now/component/form_field.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildSearchComponent({
  required BuildContext context,
  required TextEditingController searchHouse,
  required String searchTitle,
  required onSubmit,
}) {
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
          Expanded(
            flex: 5,
            child: defaultFormField(
              context: context,
              controller: searchHouse,
              label: 'Search $searchTitle',
              type: TextInputType.text,
              validate: (String? val) {
                return null;
              },
              onSubmit: onSubmit,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.topLeft,
              child: FaIcon(
                FontAwesomeIcons.search,
                color: mainColor,
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 15,
      ),
    ],
  );
}
