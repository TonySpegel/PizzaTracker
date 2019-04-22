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

        children: <Widget>[
          Row(children: <Widget>[
            Radio(
              value: 'TKP',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('TKP'),
          ]),
          Row(children: <Widget>[
            Radio(
              value: 'Restaurant',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('Restaurant'),
          ]),
          Row(children: <Widget>[
            Radio(
              value: 'Franchise',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('Franchise'),
          ]),
          Row(children: <Widget>[
            Radio(
              value: 'Selfmade',
              groupValue: radioValue,
              onChanged: handleRadioValueChanged,
            ),
            Text('Selfmade'),
          ]),
          Row(children: <Widget>[
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

    // return Wrap(
    //   children: <Widget>[
    //     Radio(
    //       value: 'TKP',
    //       groupValue: 0,
    //       onChanged: null,
    //     ),
    //     Text('TKP'),
    //     Radio(
    //       value: 'Restaurant',
    //       groupValue: 0,
    //       onChanged: null,
    //     ),
    //     Text('Restaurant'),
    //     Radio(
    //       value: 'Franchise',
    //       groupValue: 0,
    //       onChanged: null,
    //     ),
    //     Text('Franchise'),
    //     Radio(
    //       value: 'Selfmade',
    //       groupValue: 0,
    //       onChanged: null,
    //     ),
    //     Text('Selfmade'),
    //   ],
    // );
  }
}

// new RadioListTile(
//               title: const Text('TKP'),
//               value: 'TKP',
//               groupValue: _radioValue,
//               onChanged: null,
//             ),
//             new RadioListTile(
//               title: const Text('Restaurant'),
//               value: 'Restaurant',
//               groupValue: 0,
//               onChanged: null,
//             ),
//             new RadioListTile(
//               title: const Text('Franchise'),
//               value: 'Franchise',
//               groupValue: 0,
//               onChanged: null,
//             ),
//             new RadioListTile(
//               title: const Text('Selfmade'),
//               value: 'Selfmade',
//               groupValue: 0,
//               onChanged: null,
//             ),
