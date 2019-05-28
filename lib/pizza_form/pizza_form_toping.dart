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
  List<String> topings = [
    'Salami',
    'Pilze',
    'Bacon'
  ];

  deleteChip(String topingName) {
    topings.remove(topingName);
  }

  void addTopingToList() {
    print(widget.controller.text);
    setState(() {
      topings.add(widget.controller.text);
      widget.controller.clear();
    });
  }

  Widget build(BuildContext context) {

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
      onPressed: () { addTopingToList(); },
      // onPressed: (widget.controller.text.isNotEmpty) ? () =>  addTopingToList() : null,
      shape: CircleBorder(),
      elevation: 3,
      color: Colors.amber,
    );



    List<Chip> topingChips = topings.map<Chip>((toping) =>
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

    Wrap topingWrap = Wrap(
      children: topingChips,
      spacing: 8,
      runSpacing: -5,
    );

    Column topingColumn = Column(
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
        topingWrap,
      ],
    );

    return topingColumn;
  }
}
