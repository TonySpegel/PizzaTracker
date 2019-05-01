import 'package:flutter/material.dart';
// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

//
// Pizza Record
//
class Pizza {
  final DateTime date;
  final DocumentReference reference;
  final String name;
  final double quantity;
  final List topings;

  Pizza.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['quantity'] != null),
        assert(map['date'] != null),
        assert(map['topings'] != null),
        name = map['name'],
        quantity = map['quantity'].toDouble(),
        date = map['date'],
        topings = map['topings'];

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
        backgroundColor: Colors.amberAccent,
      )
    )
    .toList();

    return Container(
      child: Wrap(
        children: topingChips,
        spacing: 8,
        runSpacing: -5,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // print({this.pizza});

    final middleSection = Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              pizza.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            buildTopping(pizza.topings),
          ],
        ),
      ),
    );

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [middleSection],
        )
      )
    );
  }
}
