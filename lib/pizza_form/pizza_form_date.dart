//
// Shows the current Date / Time
//
// Copyright 2019 Tony Spegel
//

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';


class DateTimeLabel extends StatefulWidget {
  DateTimeLabel({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _DateTimeLabelState createState() => _DateTimeLabelState();
}

class _DateTimeLabelState extends State<DateTimeLabel> {
  DateTime _currentDateTime = DateTime.now();
  Timer _tickTock;

  @override
  void initState() {
    _tickTock = Timer.periodic(
      Duration(seconds: 5),
      (Timer t) {
        if (mounted) {
          setState(() {
            _currentDateTime = DateTime.now();
          });
        }
      }
    );
    super.initState();
  }

  @override
  void dispose() {
    _tickTock.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Text(
      DateFormat('dd.MM.yyyy    HH:mm').format(_currentDateTime),
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500
      ),
    );
  }
}
