import 'package:flutter/material.dart';

class Topings extends StatelessWidget {
  final List topings;

  // Constructor
  const Topings(this.topings);

  @override
  Widget build(BuildContext context) {
    List<Chip> topingChips = [];

    topingChips = topings.map<Chip>(
      (toping) => Chip(
        label: Text(toping),
        backgroundColor: Colors.amber[200],
      )
    )
    .toList();

    return Wrap(
      children: topingChips,
      spacing: 8,
      runSpacing: -5,
    );
  }
}
