import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

final HexColor mainColor = HexColor("ff9000");
final HexColor secColor = HexColor("cc7300");

final HexColor bottonColor = HexColor("D35F00");

// font size

class MainStyle {
  static TextStyle getFontSize(BuildContext context, int h) {
    switch (h) {
      case 1:
        {
          return Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 32, fontWeight: FontWeight.bold);
        }
      case 2:
        {
          return Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(fontSize: 24, fontWeight: FontWeight.w600);
        }
      case 3:
        {
          return Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(fontSize: 19, fontWeight: FontWeight.w600);
        }
      case 4:
        {
          return Theme.of(context)
              .textTheme
              .headline4!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w500);
        }
      case 5:
        {
          return Theme.of(context).textTheme.headline5!.copyWith(fontSize: 14);
        }
      case 6:
        {
          return Theme.of(context).textTheme.headline6!.copyWith(fontSize: 12);
        }
      default:
        {
          return Theme.of(context)
              .textTheme
              .headline1!
              .copyWith(fontSize: 32, fontWeight: FontWeight.bold);
        }
    }
  }
}
