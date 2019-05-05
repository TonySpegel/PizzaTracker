//
// Class to respresent a Pizza an its Values
//
// Copyright 2019 Tony Spegel
//

// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

class Pizza {
  DateTime date;
  DocumentReference reference;
  String name;
  double quantity;
  List topings;
  List type;
  String place;

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
