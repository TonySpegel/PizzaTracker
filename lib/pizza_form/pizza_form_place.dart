import 'package:flutter/material.dart';

//
// TextFormField inside pizza_form
//
// Copyright 2019 Tony Spegel
//

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
      decoration: InputDecoration(
        labelText: 'Place',

        contentPadding: EdgeInsets.all(12),
      ),
      validator: (value) {
        if (value.isEmpty) {
          _setValidity(false);
          return 'Enter Place';
        }
      },
      controller: widget.controller,
    );
  }
}
