import 'package:flutter/material.dart';

//
// TextFormField inside pizza_form
//
// Copyright 2019 Tony Spegel
//

class TopingInput extends StatefulWidget {
  TopingInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _TopingInputState createState() => _TopingInputState();
}

class _TopingInputState extends State<TopingInput> {
  void deleteChip() {
    setState(() { });
  }

  Widget build(BuildContext context) {
    return Chip(
      onDeleted: deleteChip,
      label: Text('Salami'),
      backgroundColor: Colors.amber,
    );
  }
}
