// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';
// Material Theme
import 'package:flutter/material.dart';
// Internationalization for Dates
import 'package:intl/intl.dart';
// Widgets
import 'pizza_item_screen.dart';

void main() => runApp(PizzaTracker());

class PizzaTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: new PizzaItemScreen(),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('🍕 Tracker')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('pizza-list').snapshots(),
      builder: (context, snapshot) {
        // Show Linear Progress as long as there is no data
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title:
              Text(new DateFormat('yyyy-MM-dd').format(record.date).toString()),
          trailing: Text(record.quantity.toString()),
          onTap: () => print(record),
        ),
      ),
    );
  }
}

class Record {
  final String name;
  final double quantity;
  final DocumentReference reference;
  final DateTime date;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['quantity'] != null),
        assert(map['date'] != null),
        name = map['name'],
        quantity = map['quantity'].toDouble(),
        date = map['date'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$name:$quantity:$date>";
}
