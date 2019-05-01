import 'package:flutter/material.dart';

//
// Displays the Types of Pizza inside pizza_form
//
// Copyright 2019 Tony Spegel
//

class PizzaType extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _PizzaType();
  }
}

class _PizzaType extends State<PizzaType> {
  String radioValue = 'nix';

  void handleRadioValueChanged(String value) {
    setState(() {
      radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 2/1,

        children: [
          Row(children: [
            Radio(
              value: 'TKP',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('TKP'),
          ]),
          Row(children: [
            Radio(
              value: 'Restaurant',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('Restaurant'),
          ]),
          Row(children: [
            Radio(
              value: 'Franchise',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('Franchise'),
          ]),
          Row(children: [
            Radio(
              value: 'Selfmade',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('Selfmade'),
          ]),
          Row(children: [
            Radio(
              value: 'Delivery',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('Delivery'),
          ]),
        ]
      ),
    );
  }
}
