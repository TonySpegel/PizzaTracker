//
// Represents a Pizza with its Properties stored within my Firestore.
// Some of these Properties are: Name, Toppings, Types, Date etc.
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';
// Date/Number formatting (amongst other things)
import 'package:intl/intl.dart';
import '../Pizza.dart';
import 'pizza_item_type.dart';
import 'pizza_item_topping.dart';


class PizzaItem extends StatelessWidget {
  final Pizza pizza;

  PizzaItem({ this.pizza });

  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    // Displays the first Row containing the Name of the Pizza and when it was eaten
    Padding nameAndTimeStamp = Padding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Tooltip(
                  message: '${format(pizza.quantity)} | ${pizza.place}',
                  child: Text(
                    pizza.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  )
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              // color: Colors.amberAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('dd.MM.yyyy').format(pizza.date),
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat('HH:mm').format(pizza.date),
                    style: TextStyle(
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              )
            )
          )
        ],
      ),
      padding: EdgeInsets.only(bottom: 10),
    );

    // Second Row which displays the Toppings and the Types of the Pizza
    Row toppingsAndTypes = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Toppings(pizza.toppings) ,
        ),
        Expanded(
          flex: 3,
          child: Types(pizza.type),
        ),
      ],
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  nameAndTimeStamp,
                  toppingsAndTypes,
                ],
              ),
            )
          ],
        )
      ),
      margin: EdgeInsets.all(0),
    );
  }
}
