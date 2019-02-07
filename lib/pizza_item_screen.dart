/// s/o https://github.com/PoojaB26/LayoutsFlutter/blob/master/lib/chat_item.dart
import 'package:flutter/material.dart';
import 'pizza_item.dart';

class PizzaItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('🍕 Tracker'),
        backgroundColor: Colors.amber,
      ),
      body: new PizzaItem(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        child: Icon(Icons.local_pizza),
        onPressed: () {
          _settingModalBottomSheet(context);
        },
      ),
    );
  }
}

///
/// Modal Bottom Sheet
///
void _settingModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container();
      });
}
