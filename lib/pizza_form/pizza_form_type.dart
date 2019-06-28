//
// Shows the current Date / Time
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';
import 'package:pizza_tracker/pizza_form/PizzaType.dart';
import 'package:provider/provider.dart';

class PizzaFormType extends StatefulWidget {
  @override
  _PizzaFormTypeState createState() => _PizzaFormTypeState();
}
class _PizzaFormTypeState extends State<PizzaFormType> {
  bool deliveryVal = false;
  bool familyVal = false;
  bool franchiseVal = false;
  bool restaurantVal = false;
  bool tkpVal = false;

  @override
  Widget build(BuildContext context) {
    final PizzaType typeValues = Provider.of<PizzaType>(context);

    GridView typeGrid = GridView.count(
      childAspectRatio: 7/2.4,
      crossAxisCount: 2,
      shrinkWrap: true,
      primary: false,

      children: [
        // TKP
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('TKP'),
            Checkbox(
              value: tkpVal,
              onChanged: (bool value) {
                setState(() {
                  tkpVal = value;
                });

                value == true ?
                  typeValues.addTypeToList('tkp'):
                  typeValues.removeTypeFromList('tkp');

                print(typeValues.toString());
              },
            ),
          ],
        ),
        // Franchise
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Franchise'),
            Checkbox(
              value: franchiseVal,
              onChanged: (bool value) {
                setState(() {
                  franchiseVal = value;
                });

                value == true ?
                  typeValues.addTypeToList('franchise'):
                  typeValues.removeTypeFromList('franchise');
                print(typeValues.toString());
              },
            ),
          ],
        ),
        // Restaurant
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Restaurant'),
            Checkbox(
              value: restaurantVal,
              onChanged: (bool value) {
                setState(() {
                  restaurantVal = value;
                });

                value == true ?
                  typeValues.addTypeToList('restaurant'):
                  typeValues.removeTypeFromList('restaurant');
              },
            ),
          ],
        ),
        // Family
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Family'),
            Checkbox(
              value: familyVal,
              onChanged: (bool value) {
                setState(() {
                  familyVal = value;
                });

                value == true ?
                  typeValues.addTypeToList('familienpizza'):
                  typeValues.removeTypeFromList('familienpizza');
              },
            ),
          ],
        ),
        // Delivery
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Delivery'),
            Checkbox(
              value: deliveryVal,
              onChanged: (bool value) {
                setState(() {
                  deliveryVal = value;
                });

                value == true ?
                  typeValues.addTypeToList('delivery'):
                  typeValues.removeTypeFromList('delivery');
              },
            ),
          ],
        ),
      ],
    );

    return typeGrid;
  }
}
