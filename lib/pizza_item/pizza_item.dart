//
// Represents a Pizza with its Properties stored within my Firestore.
// Some of these Properties are: Name, Toppings, Types, Date etc.
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pizza.dart';

import 'pizza_item_type.dart';
import 'pizza_item_topping.dart';


class PizzaItem extends StatelessWidget {
  final Pizza pizza;

  PizzaItem({ this.pizza });

  @override
  Widget build(BuildContext context) {
    String format(double n) {
      return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
    }

    Row nameAndTimeStamp = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Container(
            // color: Colors.amberAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Tooltip(
                  message: '${format(pizza.quantity)} | ${pizza.place}',
                  child: Text(
                    pizza.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  )
                ),
              ],
            ),
          )
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
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  ),
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
    );

    Row toppingsAndTypes = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Container(
            child: Wrap(
              children: [ Toppings(pizza.toppings) ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: Types(pizza.type),
          ),
        ),
      ],
    );

    Expanded cardElements = Expanded(
      child: Container(
        // color: Colors.black12,
        child: Column(
          children: [
            nameAndTimeStamp,
            toppingsAndTypes,
          ],
        ),
      ),
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [cardElements],
        )
      ),
      margin: EdgeInsets.all(0),
    );
  }
}
