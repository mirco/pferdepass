import 'dart:async';

import 'package:flutter/material.dart';

import 'package:pferdepass/backend/tools.dart';


class DateTimePicker extends StatelessWidget {
  DateTimePicker({this.key, this.selectedDate, this.selectDate, this.labelText}): super(key:key);

  @override
  Widget build(BuildContext c) {
    return TextField(key: key, controller: TextEditingController(text: formatDate(selectedDate)), decoration: InputDecoration(labelText: labelText), onTap: (){_selectDate(c);},);

  }

  Future<void> _selectDate(BuildContext c) async {
    final DateTime picked = await showDatePicker(context: c, initialDate: selectedDate, firstDate: DateTime(1000, 1), lastDate: DateTime.now(), initialDatePickerMode: DatePickerMode.year);
    if(picked != null && picked != selectDate)
      selectDate(picked);
  }

  final Key key;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;
  final String labelText;
}