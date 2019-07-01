//
// TextFormField inside pizza_form
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Topping.dart';


class ToppingInput extends StatefulWidget {
  ToppingInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _ToppingInputState createState() => _ToppingInputState();

}

class _ToppingInputState extends State<ToppingInput> {
  // Handles adding Toppings and clearing the corresponding Input
  void addTopping(Topping toppingList, String topping) {
    toppingList.addToppingToList(topping);
    widget.controller.clear();
  }

  Widget build(BuildContext context) {
    final Topping toppingList = Provider.of<Topping>(context);

    TextFormField toppingName = TextFormField(
      decoration: InputDecoration(
        labelText: 'Topping',
        contentPadding: EdgeInsets.all(12),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () { widget.controller.clear(); }
        )
      ),
      style: TextStyle(fontSize: 16),
      validator: (value) {},
      controller: widget.controller,
    );

    RaisedButton addTopping = RaisedButton(
      child: Icon(Icons.add),
      onPressed: (widget.controller.text.isNotEmpty) ? () =>  this.addTopping(toppingList, widget.controller.text) : null,
      shape: CircleBorder(),
      elevation: 3,
      color: Colors.amber,
    );


    // List of Chips containing a Topping
    List<Chip> toppingChips = toppingList.toppings
      .map<Chip>((topping) =>
        Chip(
          key: ValueKey<String>(topping),
          backgroundColor: Colors.amber[200],
          label: Text(topping),
          onDeleted: () {
            setState(() {
              toppingList.removeToppingFromList(topping);
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
            child: toppingName,
          ),

          Flexible(
            flex: 3,
            child: addTopping,
            fit: FlexFit.tight,
          ),
        ]),

        Divider(),

        Wrap(
          children: toppingChips,
          spacing: 8,
          runSpacing: -5,
        ),
      ],
    );
  }
}
