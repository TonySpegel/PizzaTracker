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

  //
  // Define Layout Elements
  //
  final leftSection = Container(
    child: CircleAvatar(
      backgroundImage: NetworkImage(
          'https://cdn.pixabay.com/photo/2016/03/31/19/58/avatar-1295429_960_720.png'),
      backgroundColor: Colors.amber,
      radius: 24.0,
    ),
  );

  final rightSection = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          '9:50',
          style: TextStyle(color: Colors.lightGreen, fontSize: 12.0),
        ),
        CircleAvatar(
          backgroundColor: Colors.black38,
          radius: 10.0,
          child: Text(
            '1',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
        )
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    print({this.pizza});

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
            Text(
              pizza.topings.join(', '),
              style: TextStyle(color: Colors.grey),
            ),
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
          children: <Widget>[leftSection, middleSection, rightSection],
        )
      )
    );
  }
}
