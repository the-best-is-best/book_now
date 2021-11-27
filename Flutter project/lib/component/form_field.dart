import 'package:flutter/material.dart';

Widget defaultFormField({
  required BuildContext context,
  required TextEditingController? controller,
  required TextInputType type,
  dynamic onSubmit,
  dynamic onChange,
  bool isPassword = false,
  required dynamic validate,
  required String label,
  IconData? prefix,
  IconData? suffix,
  dynamic suffixPressed,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onChanged: onChange,
    validator: validate,
    style: Theme.of(context).textTheme.bodyText1,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: Theme.of(context).textTheme.bodyText1,
      prefixIcon: Icon(
        prefix,
      ),
      suffixIcon: suffix != null
          ? IconButton(
              onPressed: suffixPressed,
              icon: Icon(
                suffix,
              ),
            )
          : null,
      border: const OutlineInputBorder(),
    ),
  );
}
