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
    RaisedButton addToping = RaisedButton(
      child: Icon(Icons.add),
      onPressed: null,
      shape: CircleBorder(),
      elevation: 10,
    );

    List<String> topings = [
      'Tomaten',
      'Salami',
      'Mozzarella',
      'Basilikum',
    ];

    List<Chip> topingChips = topings.map<Chip>(
      (toping) => Chip(
        backgroundColor: Colors.amber[200],
        label: Text(toping),
        onDeleted: deleteChip,
        labelStyle: TextStyle(
          fontSize: 16,
          color: Colors.black
        ),
      )
    )
    .toList();

    Wrap topingWrap = Wrap(
      children: topingChips,
      spacing: 8,
      runSpacing: -5,
    );

    Column topingColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [ addToping ]),
        Divider(),
        topingWrap,
      ],
    );

    return topingColumn;
  }
}
