import 'package:flutter/material.dart';
import 'package:pferdepass/backend/tools.dart';

class DateTimePicker extends StatelessWidget {
  DateTimePicker({this.selectedDate, this.selectDate, this.labelText});

  @override
  Widget build(BuildContext c) {
    return TextField(
      controller: TextEditingController(text: formatDate(selectedDate)),
      decoration: InputDecoration(labelText: labelText),
      onTap: () => _selectDate(c),
    );
  }

  Future<void> _selectDate(BuildContext c) async {
    final DateTime picked = await showDatePicker(
        context: c,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(1000, 1),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
    if (picked != null && picked != selectDate) return selectDate(picked);
  }

  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;
  final String labelText;
}
