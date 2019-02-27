// Material Theme
import 'package:flutter/material.dart';

// FireStore
import 'package:cloud_firestore/cloud_firestore.dart';

import 'pizza_item.dart';

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();
  Firestore db = new Firestore();

  Future<Pizza> addPizza(
    DateTime date
    String name,
    String place,
    String producer,
    double quantity,
    List topings,
    String type
  ) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(db.collection('pizza-list').document());

      var dataMap = new Map<String, dynamic>();
      dataMap['date'] = date;
      dataMap['name'] = name;
      dataMap['place'] = place;
      dataMap['producer'] = producer;
      dataMap['quantity'] = quantity;
      dataMap['topings'] = topings;
      dataMap['type'] = type;

      await tx.set(ds.reference, dataMap);

      return dataMap;
    };

  return Firestore.instance.runTransaction(createTransaction)
    .then((mapData) {
      return Pizza.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Enter Data for your new 🍕',
              style: Theme.of(context).textTheme.headline,
            ),
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 12.0),
                    child: new Icon(
                        Icons.local_pizza), // myIcon is a 48px-wide widget.
                  )
                  // focusedBorder: const OutlineInputBorder(
                  //   borderSide: const BorderSide(color: Colors.red, width: 1.0),
                  // ),
                  ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'bruh enter some text';
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            Center(
              child: RaisedButton(
                color: Colors.amber,
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }

                  addPizza(
                    DateTime.now(),
                    'Ristorante Salami',
                    'Zu Hause',
                    'Ristorante',
                    1,
                    ['Salami'],
                    'TKP'
                  );
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text('Add new'),
                    new Icon(Icons.local_pizza),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
