import 'package:flutter/material.dart';

//
// TextFormField inside pizza_form
//
// Copyright 2019 Tony Spegel
//

class DateInput extends StatefulWidget {
  DateInput({Key key, this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _DateInputState createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  bool _isValid = true;

  void _setValidity(bool state) {
    setState(() {
      _isValid = state;
    });
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101)
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime
    );

    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }

  Widget build(BuildContext context) {
    IconButton datePicker = IconButton(
      onPressed: () => _selectDate(context),
      icon: Icon(Icons.event),
    );

    IconButton timePicker = IconButton(
      onPressed: () => _selectTime(context),
      icon: Icon(Icons.access_time),
    );

    Row dateTimePicker = Row(
      children: [
        datePicker,
        timePicker
      ],
    );

    return dateTimePicker;
  }
}


