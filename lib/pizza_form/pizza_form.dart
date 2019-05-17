// Material Theme
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'pizza_type.dart';
import 'pizza_form_name.dart';
// DateInput
import 'pizza_form_date.dart';
// PlaceInput
import 'pizza_form_place.dart';
import 'pizza_form_toping.dart';

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

  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final dateTimeController = TextEditingController();
  final placeController = TextEditingController();


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
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.label),
              title: NameInput(controller: nameController),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.local_pizza),
              title: TopingInput(controller: nameController),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.event_available),
              title: DateTimeLabel(
                controller: dateTimeController
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.widgets),
              contentPadding: EdgeInsets.all(0),
              title: PizzaType(),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.place),
              title: PlaceInput(controller: placeController),
            ),
            // ListTile(
            //   contentPadding: EdgeInsets.all(0),
            //   leading: Icon(Icons.place),
            //   title:  FlatButton(
            //     color: Colors.amber,
            //     onPressed: () {},
            //     child: Text(
            //       'Location',
            //       style: TextStyle(fontSize: 20)
            //     ),
            //   ),
            // ),
          ],
        )
      )
    );
  }

    //         Center(
    //           child: RaisedButton(
    //             color: Colors.amber,
    //             onPressed: () {
    //               // Validate will return true if the form is valid, or false if
    //               // the form is invalid.
    //               if (_formKey.currentState.validate()) {
    //                 newPizza();
    //               }
    //             },
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Text('Add new'),
    //                 Icon(Icons.local_pizza),
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
}
