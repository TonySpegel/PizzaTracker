//
// Displays Toppings of a Pizza as Chips inside
// 'pizza_item.dart'
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';

class Toppings extends StatelessWidget {
  final List toppings;

  // Constructor
  const Toppings(this.toppings);

  @override
  Widget build(BuildContext context) {
    List<Chip> toppingChips = [];

    toppingChips = toppings.map<Chip>(
      (topping) => Chip(
        label: Text(topping),
        backgroundColor: Colors.amber[200],
      )
    )
    .toList();

    return Wrap(
      children: toppingChips,
      spacing: 8,
      runSpacing: -5,
    );
  }
}
