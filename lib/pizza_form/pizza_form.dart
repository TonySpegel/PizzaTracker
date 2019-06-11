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
import 'pizza_form_toping.dart';

import 'toping.dart';

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
  final topingController = TextEditingController();


  Future newPizza() async {
    String pizzaName = nameController.text;
    String place = placeController.text;
    print(topingController.text);

    Firestore db = Firestore.instance;

    Map <String, dynamic> newMap = new Map();

    newMap.addAll({
      'name': pizzaName,
      'type': ['Restaurant', 'Franchise'],
      'quantity':  1,
      'place': place,
      'date': DateTime.now(),
      'topings': ['Funghi', 'Salami', 'Mozzarella'],
    });

    // db
    //   .collection('pizza-list')
    //   .add(newMap);
  }

  void onChange() {
    setState(() {
      formValidity = _formKey.currentState.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => Toping(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          onChanged: onChange,
          autovalidate: false,
          child: ListView(
            children: [
              // Pizza-Name
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.label),
                title: NameInput(controller: nameController),
              ),
              Divider(),
              // Topings
              ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.local_pizza),
                title: TopingInput(controller: topingController),
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
                  onPressed: formValidity ? newPizza : null,
                  child: Icon(Icons.local_pizza),
                ),
              )
            ],
          )
        )
      )
    );
  }
}
