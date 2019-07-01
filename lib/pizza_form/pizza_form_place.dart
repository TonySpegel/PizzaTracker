//
// TextFormField to enter a Place where a Pizza has been eaten
// Located in → pizza_form.dart.
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';


class PlaceInput extends StatefulWidget {
  PlaceInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _PlaceInputState createState() => _PlaceInputState();
}

class _PlaceInputState extends State<PlaceInput> {
  bool _isValid = true;

  void _setValidity(bool state) {
    setState(() {
      _isValid = state;
    });
  }

  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'Place',
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
          _setValidity(false);
          return 'Enter Place';
        }
      },
    );
  }
}
