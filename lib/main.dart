// Material Theme
import 'package:flutter/material.dart';
// Widgets
import 'pizza_item_screen.dart';

import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled=false;
  runApp(PizzaTracker());
}

class PizzaTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new PizzaItemScreen(),
      theme: ThemeData(
        accentColor: Colors.amber,
        buttonColor: Colors.amber,
        primaryColor: Colors.amber,
        appBarTheme: AppBarTheme(color: Colors.amber),
        cursorColor: Colors.amber,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 1.0),
          ),
          labelStyle: TextStyle(color: Colors.amber)
        ),
        toggleableActiveColor: Colors.amber,
        primarySwatch: Colors.amber
      ),
    );
  }
}
