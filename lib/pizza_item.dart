import 'package:flutter/material.dart';
// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

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

  Pizza.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['quantity'] != null),
        assert(map['date'] != null),
        assert(map['topings'] != null),
        assert(map['type'] != null),
        name = map['name'],
        quantity = map['quantity'].toDouble(),
        date = map['date'],
        topings = map['topings'],
        type = map['type'];

  Pizza.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Pizza<$name:$quantity:$date:$topings>";
}

class PizzaItem extends StatelessWidget {
  final Pizza pizza;

  PizzaItem({this.pizza});

  Widget buildTopping(topings) {
    List<Chip> topingChips = [];

    topingChips = topings.map<Chip>(
      (toping) => Chip(
        label: Text(toping),
        backgroundColor: Colors.amber[200],
      )
    )
    .toList();

    return Wrap(
      children: topingChips,
      spacing: 8,
      runSpacing: -5,
    );
  }

  Widget buildTypes(types) {
    List<IconButton> typeIconButtons = [];

    typeIconButtons = types.map<IconButton>(
      (type) {
        type = type.toString().toLowerCase();

        switch (type) {
          case 'tkp':
            return IconButton(
              icon: Icon(Icons.ac_unit),
              tooltip: 'TKP',
              onPressed: () {},
            );
            break;

          case 'delivery':
            return IconButton(
              icon: Icon(Icons.local_shipping),
              tooltip: 'Delivery',
              onPressed: () {},
            );
            break;

          case 'restaurant':
            return IconButton(
              icon: Icon(Icons.restaurant),
              tooltip: 'Restaurant',
              onPressed: () {},
            );
            break;

          case 'selfmade':
            return IconButton(
              icon: Icon(Icons.person),
              tooltip: 'Selfmade',
              onPressed: () {},
            );
            break;

          case 'franchise':
            return IconButton(
              icon: Icon(Icons.domain),
              tooltip: 'Franchise',
              onPressed: () {},
            );
            break;

          case 'familienpizza':
            return IconButton(
              icon: Icon(Icons.supervisor_account),
              tooltip: 'Family',
              onPressed: () {},
            );
            break;

          default:
        }
      }
    )
    .toList();

    return Wrap(
      children: typeIconButtons,
    );
  }

  @override
  Widget build(BuildContext context) {

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
              Text(
                pizza.name,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
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
              children: [ buildTopping(pizza.topings) ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            child: buildTypes(pizza.type),
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
