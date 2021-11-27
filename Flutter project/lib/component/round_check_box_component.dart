import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

RoundCheckBox defaultRoundCheckBox(dynamic function, bool? value) {
  return RoundCheckBox(
    onTap: function,
    isChecked: value,
    size: 40,
    uncheckedColor: secColor,
    checkedColor: mainColor,
    uncheckedWidget: const Icon(
      Icons.check_box_outline_blank_rounded,
      color: Colors.black,
    ),
    checkedWidget: const Icon(
      Icons.check_box_rounded,
      color: Colors.white,
    ),
  );
}
