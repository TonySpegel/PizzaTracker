/// s/o https://github.com/PoojaB26/LayoutsFlutter/blob/master/lib/chat_item.dart
import 'package:flutter/material.dart';
import 'pizza_item.dart';
import 'package:flutter/foundation.dart';

// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

class PizzaItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🍕 Tracker'),
        backgroundColor: Colors.amber,
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.local_pizza),
        onPressed: () { },
      ),
    );
  }
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
  final pizza = Pizza.fromSnapshot(data);

  return Padding(
    key: ValueKey(pizza.name),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),

    child: Container(
      child: PizzaItem(),
    ),
  );
}
