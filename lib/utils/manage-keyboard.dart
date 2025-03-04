// ignore_for_file: file_names

import 'package:flutter/material.dart';

class KeyboardUtil {
  static void hidekeyboard(BuildContext context) {
    FocusScopeNode currentfocu = FocusScope.of(context);
    if (!currentfocu.hasPrimaryFocus) {
      currentfocu.unfocus();
    }
  }
}
