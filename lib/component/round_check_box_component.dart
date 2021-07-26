import 'package:book_now/provider/rel/rel_people_provider.dart';
import 'package:book_now/style/main_style.dart';
import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

RoundCheckBox defaultRoundCheckBox(
    RelPeopleProvider myRelPeopleRead, RelPeopleProvider myRelPeopleWatch) {
  return RoundCheckBox(
    onTap: (_) => myRelPeopleRead,
    isChecked: myRelPeopleWatch.bones,
    size: 40,
    uncheckedColor: secColor,
    checkedColor: mainColor,
    uncheckedWidget: Icon(
      Icons.check_box_outline_blank_rounded,
      color: Colors.black,
    ),
    checkedWidget: Icon(
      Icons.check_box_rounded,
      color: Colors.white,
    ),
  );
}
