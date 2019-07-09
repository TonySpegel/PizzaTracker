//
// Main File
//
// Copyright 2019 Tony Spegel
//

// Material Theme
import 'package:flutter/material.dart';

// Dependency Injection System for Statemanagement.
import 'package:provider/provider.dart';

// Widgets
import 'pizza_form/Topping.dart';
import 'pizza_form/PizzaType.dart';
import 'pizza_item_screen.dart';

// Needed to set debugPaintSizeEnabled
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled=false;
  runApp(PizzaTracker());
}

class PizzaTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => Topping()),
        ChangeNotifierProvider(builder: (context) => PizzaType()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PizzaItemScreen(),
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
      ),
    );
  }
}
