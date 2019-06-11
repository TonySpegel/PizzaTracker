import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'toping.dart';

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
  List<String> topings = [
    'Salami',
    'Pilze',
    'Bacon'
  ];

  deleteChip(String topingName) {
    final Toping topingList = Provider.of<Toping>(context);
    topingList.removeTopingFromList(topingName);
  }

  void addTopingToList() {
    String topingItem = widget.controller.text;

    setState(() {
      topings.add(topingItem);
      widget.controller.clear();
    });

    var topingList = Provider.of<Toping>(context);
    topingList.topings.add(topingItem);
  }

  Widget build(BuildContext context) {
    final Toping topingList = Provider.of<Toping>(context);


    TextFormField topingName = TextFormField(
      decoration: InputDecoration(
        labelText: 'Toping',
        contentPadding: EdgeInsets.all(12),
      ),
      style: TextStyle(fontSize: 16),
      validator: (value) {},
      controller: widget.controller,
    );

    RaisedButton addToping = RaisedButton(
      child: Icon(Icons.add),
      onPressed: () {
        topingList.addTopingToList(widget.controller.text);
      },
      // onPressed: (widget.controller.text.isNotEmpty) ? () =>  addTopingToList() : null,
      shape: CircleBorder(),
      elevation: 3,
      color: Colors.amber,
    );



    List<Chip> topingChips = topingList.topings
      .map<Chip>((toping) =>
        Chip(
          key: ValueKey<String>(toping),
          backgroundColor: Colors.amber[200],
          label: Text(toping),
          onDeleted: () {
            setState(() {
              deleteChip(toping);
            });
          },
          labelStyle: TextStyle(
            fontSize: 16,
            color: Colors.black
          ),
        )
      )
      .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Flexible(
            flex: 7,
            child: topingName,
          ),

          Flexible(
            flex: 3,
            child: addToping,
            fit: FlexFit.tight,
          ),
        ]),

        Divider(),

        Wrap(
          children: topingChips,
          spacing: 8,
          runSpacing: -5,
        ),
      ],
    );
  }
}
