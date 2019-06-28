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
  bool _isValid = true;

  void _setValidity(bool state) {
    setState(() {
      _isValid = state;
    });
  }

  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
        contentPadding: EdgeInsets.all(12),
      ),
      style: TextStyle(
        fontSize: 16
      ),
      validator: (value) {
        if (value.isEmpty) {
          _setValidity(false);
          return 'Enter Pizzaname';
        }
      },
      controller: widget.controller,
    );
  }
}


