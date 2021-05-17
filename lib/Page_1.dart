import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ChatScreen.dart';


final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

class Page1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChatScreen();
  }
}

