import 'package:flutter/material.dart';

class Managekeyboard {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentfocus = FocusScope.of(context);
    if (!currentfocus.hasPrimaryFocus) {
      currentfocus.unfocus();
    } 
  }
}
