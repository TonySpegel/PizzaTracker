// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';
// Material Theme
import 'package:flutter/material.dart';
// Internationalization for Dates
import 'package:intl/intl.dart';
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
    );
  }
}
