// Material Theme
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'pizza_type.dart';
import 'pizza_form_name.dart';
// DateInput
import 'pizza_form_date.dart';
// PlaceInput
import 'pizza_form_place.dart';
import 'pizza_form_topping.dart';

import 'topping.dart';

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
  bool formValidity = false;

  final nameController = TextEditingController();
  final quantityController = TextEditingController();
  final dateTimeController = TextEditingController();
  final placeController = TextEditingController();
  final toppingController = TextEditingController();


  newPizza(
    String name,
    List<String> toppings
  ) async {
    String place = placeController.text;
    print(toppingController.text);

    Firestore db = Firestore.instance;

    Map <String, dynamic> newMap = new Map();

    newMap.addAll({
      'name': name,
      'type': ['Restaurant', 'Franchise'],
      'quantity':  1,
      'place': place,
      'date': DateTime.now(),
      'toppings': toppings,
    });

    db
      .collection('pizza-list')
      .add(newMap);
  }

  void onChange() {
    setState(() {
      formValidity = _formKey.currentState.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    var toppingList = Provider.of<Topping>(context);
    List<String> toppings = toppingList.toppings;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Form(
        key: _formKey,
        onChanged: onChange,
        // autovalidate: false,
        child: ListView(
          children: [
            // Pizza-Name
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.label),
              title: NameInput(controller: nameController),
            ),
            Divider(),
            // Toppings
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.local_pizza),
              title: ToppingInput(controller: toppingController),
            ),
            Divider(),
            // Date & Time
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.event_available),
              title: DateTimeLabel(controller: dateTimeController),
            ),
            Divider(),
            // Pizza-Type
            ListTile(
              leading: Icon(Icons.widgets),
              contentPadding: EdgeInsets.all(0),
              title: PizzaType(),
            ),
            Divider(),
            // Place
            ListTile(
              contentPadding: EdgeInsets.all(0),
              leading: Icon(Icons.place),
              title: PlaceInput(controller: placeController),
            ),
            Divider(),
            // Form-Button
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: RaisedButton(
                onPressed:
                  // formValidity ?
                  //   newPizza(
                  //     nameController.text,
                  //     toppings
                  //   ) :
                  //   null,
                  () => newPizza(
                    nameController.text,
                    toppings
                  ),
                child: Icon(Icons.local_pizza),
              ),
            )
          ],
        )
      )
    );
  }
}
