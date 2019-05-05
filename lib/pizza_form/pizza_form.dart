// Material Theme
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'pizza_form_type.dart';

// Create a Form Widget
class PizzaForm extends StatefulWidget {
  @override
  PizzaFormState createState() {
    return PizzaFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class PizzaFormState extends State<PizzaForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<PizzaFormState>!
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();


  Future newPizza() async {
    String pizzaName = nameController.text;
    Firestore db = Firestore.instance;

    Map <String, dynamic> newMap = new Map();

    newMap.addAll({
      'name': pizzaName,
      'type': ['Restaurant', 'Franchise'],
      'quantity':  1,
      'place': 'TEST: Zu Hause',
      'date': DateTime.now(),
      'topings': ['Funghi', 'Salami', 'Mozzarella'],
    });

    db
      .collection('pizza-list')
      .add(newMap);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                'New 🍕',
                style: Theme.of(context).textTheme.headline,
              )
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: '🍕 Name',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Enter Pizzaname';
                }
              },
              controller: nameController,
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                'Type',
                style: Theme.of(context).textTheme.title,
              )
            ),

            PizzaType(),

            Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text(
                'Place',
                style: Theme.of(context).textTheme.title,
              )
            ),

            Center(
              child: RaisedButton(
                color: Colors.amber,
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    newPizza();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Add new'),
                    Icon(Icons.local_pizza),
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
