import 'package:flutter/material.dart';

//
// TextFormField inside pizza_form
//
// Copyright 2019 Tony Spegel
//

class QuantityInput extends StatefulWidget {
  QuantityInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _QuantityInputState createState() => _QuantityInputState();
}

class _QuantityInputState extends State<QuantityInput> {
  bool _isValid = true;

  void _setValidity(bool state) {
    setState(() {
      _isValid = state;
    });
  }

  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Quantity',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      keyboardType: TextInputType.number,
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


