import 'package:flutter/material.dart';
// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

import 'pizza_item_type.dart';
import 'pizza_item_toping.dart';

//
// Pizza Record
//
class Pizza {
  final DateTime date;
  final DocumentReference reference;
  final String name;
  final double quantity;
  final List topings;
  final List type;
  final String place;

  Pizza.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['quantity'] != null),
        assert(map['date'] != null),
        assert(map['topings'] != null),
        assert(map['type'] != null),
        assert(map['place'] != null),
        name = map['name'],
        quantity = map['quantity'].toDouble(),
        date = map['date'],
        topings = map['topings'],
        type = map['type'],
        place = map['place'];

  Pizza.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Pizza<$name:$quantity:$date:$topings>";
}

class PizzaItem extends StatelessWidget {
  final Pizza pizza;

  PizzaItem({this.pizza});

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
                message: "${format(pizza.quantity)} | ${pizza.place}",
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
                  DateFormat('yyyy.MM.dd').format(pizza.date),
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

    Row topingsAndTypes = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Container(
            child: Wrap(
              children: [ Topings(pizza.topings) ],
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
            topingsAndTypes,
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
      )
    );
  }
}
