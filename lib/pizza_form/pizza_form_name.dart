//
// TextFormField inside pizza_form
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';


class NameInput extends StatefulWidget {
  NameInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _NameInputState createState() => _NameInputState();
}

class _NameInputState extends State<NameInput> {
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        contentPadding: EdgeInsets.all(12),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () { widget.controller.clear(); }
        )
      ),
      style: TextStyle(
        fontSize: 16
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Enter Pizzaname';
        }
      },
      controller: widget.controller,
    );
  }
}


