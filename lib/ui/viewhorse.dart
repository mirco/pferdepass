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

import 'package:Pferdepass/backend/gender.dart';
import 'package:Pferdepass/backend/horse.dart';
import 'package:Pferdepass/backend/horseDB.dart';
import 'package:Pferdepass/backend/tools.dart';
import 'package:Pferdepass/backend/ueln.dart';
import 'package:Pferdepass/generated/i18n.dart';
import 'package:Pferdepass/ui/dateTimePicker.dart';
import 'package:flutter/material.dart';

class ViewHorse extends StatefulWidget {
  @override
  _ViewHorseState createState() =>
      _ViewHorseState(horse: horse, horseDb: horseDb);

  ViewHorse({@required this.horse, @required this.horseDb});

  factory ViewHorse.forDesignTime() {
    Horse designTimeHorse = Horse(name: 'DesignTimeHorse');
    HorseDb designTimeDb = HorseDb(dbName: 'designTimeDb');
    return new ViewHorse(horse: designTimeHorse, horseDb: designTimeDb);
  }

  final Horse horse;
  final HorseDb horseDb;
}

class _ViewHorseState extends State<ViewHorse> {
  _ViewHorseState({@required this.horse, @required this.horseDb}) {
    assert(horse != null);
    assert(horseDb != null);
  }

  @override
  Widget build(BuildContext c) {
    var s = S.of(c);
    var widgetList = <Widget>[
      _buildTextFieldWidget(
        labelText: s.sportsname,
        content: horse.sportsName,
        callback: (String sportsName) => horse.sportsName = sportsName,
      ),
      _buildTextFieldWidget(
        labelText: s.breedname,
        content: horse.breedName,
        callback: (String breedName) => horse.breedName = breedName,
      ),
      _buildTextFieldWidget(
          labelText: s.ueln,
          content: horse.ueln,
          callback: (ueln) {
            // TODO: make ueln editable
            try {
              horse.ueln = Ueln.fromString(ueln);
            } on FormatException {}
          }),
      DateTimePicker(
        selectedDate: horse.dateOfBirth,
        onSelectDate: (date) => setState(() => horse.dateOfBirth = date),
        labelText: s.dateOfBirth,
      ),
      _buildDropdownButtonFieldWidget<Race>(
        labelText: s.race,
        items: raceStrings,
        value: horse.race,
        context: c,
        callback: (race) => horse.race = race,
      ),
      _buildDropdownButtonFieldWidget<Color>(
        labelText: s.color,
        items: colorStrings,
        value: horse.color,
        context: c,
        callback: (color) => horse.color = color,
      ),
      _buildDropdownButtonFieldWidget<genderType>(
          labelText: s.gender,
          items: Gender.genderStrings,
          value: horse.gender.gender,
          context: c,
          callback: (gender) {
            horse.gender = Gender(gender: gender);
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        title: TextField(
            controller: TextEditingController(text: horse.name ?? ''),
            onChanged: (name) => setState(() => horse.name = name)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              horseDb.saveDb();
              Navigator.pop(c, horse);
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              tooltip: s.delete_horse,
              onPressed: () {
                horseDb.remove(horse);
                Navigator.pop(c);
              }),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: widgetList,
        ),
      ),
    );
  }

  Widget _buildTextFieldWidget<T>({
    @required String labelText,
    var content = '',
    Widget onClicked,
    _HorseCallback<String> callback,
    BuildContext context,
  }) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      controller: TextEditingController(
        text: () {
          content ??= '';
          if (content is Localized) {
            return content.toLocalizedString(context);
          } else
            return content.toString();
        }(),
      ),
      onChanged: (String value) => setState(() => callback(value)),
    );
  }

  Widget _buildDropdownButtonFieldWidget<T>(
      {@required String labelText,
      @required Map<T, LocalizedString> items,
      T value,
      _HorseCallback<T> callback,
      @required BuildContext context}) {
    final dropdownList = items.map((key, value) => MapEntry(
        key, DropdownMenuItem(value: key, child: Text(value(context)))));

    return Row(children: [
      Expanded(
          child: Text(
        labelText,
        textAlign: TextAlign.left,
      )),
      DropdownButton<T>(
        value: value,
        hint: Text(labelText),
        items: dropdownList.values.toList(),
        onChanged: (T value) => setState(() => callback(value)),
      )
    ]);
  }

  final Horse horse;
  final HorseDb horseDb;
}

typedef _HorseCallback<T> = T Function(T);
