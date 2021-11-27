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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: query.width * .75,
            child: defaultFormField(
              context: context,
              controller: searchController,
              label: searchTitle,
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
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
