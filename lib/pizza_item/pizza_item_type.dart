import 'package:flutter/material.dart';

class Types extends StatelessWidget {
  final List types;

  // Constructor
  const Types(this.types);

  @override
  Widget build(BuildContext context) {
    List<IconButton> typeIconButtons = [];

    typeIconButtons = types.map<IconButton>(
      (type) {
        type = type.toString().toLowerCase();

        switch (type) {
          case 'tkp':
            return IconButton(
              icon: Icon(Icons.ac_unit),
              tooltip: 'TKP',
              onPressed: () {},
            );
            break;

          case 'delivery':
            return IconButton(
              icon: Icon(Icons.local_shipping),
              tooltip: 'Delivery',
              onPressed: () {},
            );
            break;

          case 'restaurant':
            return IconButton(
              icon: Icon(Icons.restaurant),
              tooltip: 'Restaurant',
              onPressed: () {},
            );
            break;

          case 'selfmade':
            return IconButton(
              icon: Icon(Icons.person),
              tooltip: 'Selfmade',
              onPressed: () {},
            );
            break;

          case 'franchise':
            return IconButton(
              icon: Icon(Icons.domain),
              tooltip: 'Franchise',
              onPressed: () {},
            );
            break;

          case 'familienpizza':
            return IconButton(
              icon: Icon(Icons.supervisor_account),
              tooltip: 'Family',
              onPressed: () {},
            );
            break;

          case 'wfngtn':
            return IconButton(
              icon: Icon(Icons.local_florist),
              tooltip: 'Garden',
              onPressed: () {},
            );
            break;

          default:
        }
      }
    )
    .toList();

    return Container(
      alignment: Alignment.center,
      child: Wrap(
        children: typeIconButtons,
        crossAxisAlignment: WrapCrossAlignment.center,
        runAlignment: WrapAlignment.center,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.amber[100],
      ),
      height: 100,
    );
  }
}
