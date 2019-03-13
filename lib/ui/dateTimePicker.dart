/* This file is part of Pferdepass.                                           */
/*                                                                            */
/* Pferdepass is free software: you can redistribute it and/or modify         */
/* it under the terms of the GNU General Public License as published by       */
/* the Free Software Foundation, either version 3 of the License, or          */
/* (at your option) any later version.                                        */
/*                                                                            */
/* Pferdepass is distributed in the hope that it will be useful,              */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of             */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              */
/* GNU General Public License for more details.                               */
/*                                                                            */
/* You should have received a copy of the GNU General Public License          */
/* along with Pferdepass.  If not, see <https://www.gnu.org/licenses/>.       */

import 'package:Pferdepass/backend/tools.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
  DateTimePicker({this.selectedDate, this.selectDate, this.labelText});

  @override
  Widget build(BuildContext c) => Row(children: <Widget>[
        Expanded(child: Text(labelText)),
        FlatButton(
            child: Text(formatDate(selectedDate)),
            onPressed: () => _selectDate(c))
      ]);

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
