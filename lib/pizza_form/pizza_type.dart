import 'package:flutter/material.dart';

class PizzaType extends StatefulWidget {
  @override
  _PizaTypeState createState() => _PizaTypeState();
}
class _PizaTypeState extends State<PizzaType> {
  bool deliveryVal = false;
  bool familyVal = false;
  bool franchiseVal = false;
  bool restaurantVal = false;
  bool tkpVal = false;

  @override
  Widget build(BuildContext context) {
    GridView typeGrid = GridView.count(
      childAspectRatio: 7/4.7,
      crossAxisCount: 3,
      shrinkWrap: true,
      primary: false,

      children: [
        // TKP
        Column(
          children: [
            Text('TKP'),
            Checkbox(
              value: tkpVal,
              onChanged: (bool value) {
                setState(() {
                  tkpVal = value;
                });
              },
            ),
          ],
        ),
        // Franchise
        Column(

          children: [
            Text('Franchise'),
            Checkbox(
              value: franchiseVal,
              onChanged: (bool value) {
                setState(() {
                  franchiseVal = value;
                });
              },
            ),
          ],
        ),
        // Restaurant
        Column(
          children: [
            Text('Restaurant'),
            Checkbox(
              value: restaurantVal,
              onChanged: (bool value) {
                setState(() {
                  restaurantVal = value;
                });
              },
            ),
          ],
        ),
        // Family
        Column(
          children: [
            Text('Family'),
            Checkbox(
              value: familyVal,
              onChanged: (bool value) {
                setState(() {
                  familyVal = value;
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            Text('Delivery'),
            Checkbox(
              value: deliveryVal,
              onChanged: (bool value) {
                setState(() {
                  deliveryVal = value;
                });
              },
            ),
          ],
        ),
      ],
    );

    return typeGrid;
  }
}



// return Wrap(
    //   children: [
    //     Column(
    //       children: [
    //         Text('Restaurant'),
    //         Checkbox(
    //           value: restaurantVal,
    //           onChanged: (bool value) {
    //             setState(() {
    //               restaurantVal = value;
    //             });
    //           },
    //         ),
    //       ],
    //     ),
    //   ],
    // );
