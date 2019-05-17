import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

//
// TextFormField inside pizza_form
//
// Copyright 2019 Tony Spegel
//

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

// TODO: Variant w/ date|timePicker

// DateTime selectedDate = DateTime.now();
// TimeOfDay selectedTime = TimeOfDay.now();

// Future<Null> _selectDate(BuildContext context) async {
//   final DateTime picked = await showDatePicker(
//     context: context,
//     initialDate: selectedDate,
//     firstDate: DateTime(2015, 8),
//     lastDate: DateTime(2101)
//   );

//   if (picked != null && picked != selectedDate)
//     setState(() {
//       selectedDate = picked;
//     });
// }

// Future<Null> _selectTime(BuildContext context) async {
//   final TimeOfDay picked = await showTimePicker(
//     context: context,
//     initialTime: selectedTime
//   );

//   if (picked != null && picked != selectedTime)
//     setState(() {
//       selectedTime = picked;
//     });
// }


// IconButton datePicker = IconButton(
//   onPressed: () => _selectDate(context),
//   icon: Icon(Icons.event),
// );

// IconButton timePicker = IconButton(
//   onPressed: () => _selectTime(context),
//   icon: Icon(Icons.access_time),
// );

// Row dateTimePicker = Row(
//   children: [
//     datePicker,
//     timePicker
//   ],
// );
