import 'package:flutter/material.dart';

class PizzaType extends StatefulWidget {
  @override
  _PizaTypeState createState() => _PizaTypeState();
}
class _PizaTypeState extends State<PizzaType> {
  bool tkpVal = false;
  bool franchiseVal = false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(
            value: tkpVal,
            onChanged: (bool value) {
              setState(() {
                tkpVal = value;
              });
            },
          ),
          Text('TKP'),
          Checkbox(
            value: franchiseVal,
            onChanged: (bool value) {
              setState(() {
                franchiseVal = value;
              });
            },
          ),
          Text('Franchise'),
        ],
      )
    );
  }
}

