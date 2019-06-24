// Material Theme
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Widgets
import 'pizza_form/topping.dart';
import 'pizza_item_screen.dart';

import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled=false;
  runApp(PizzaTracker());
}

class PizzaTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Topping(),
      child: MaterialApp(
      home: new PizzaItemScreen(),
      theme: ThemeData(
        accentColor: Colors.amber,
        buttonColor: Colors.amber,
        primaryColor: Colors.amber,
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
    )
    );
  }
}
