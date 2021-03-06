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

import 'package:Pferdepass/backend/event.dart';
import 'package:Pferdepass/backend/horse.dart';
import 'package:Pferdepass/backend/horseDB.dart';
import 'package:Pferdepass/backend/horse_util.dart';
import 'package:Pferdepass/backend/ueln.dart';
import 'package:Pferdepass/generated/i18n.dart';
import 'package:flutter/material.dart';

import 'dateTimePicker.dart';
import 'drawer.dart';
import 'eventWidget.dart';

class ViewHorseScreen extends StatefulWidget {
  final Horse horse;
  final HorseDb horseDb;

  _ViewHorseScreenState createState() =>
      _ViewHorseScreenState(horse: horse, horseDb: horseDb);

  ViewHorseScreen({@required this.horse, @required this.horseDb});

  factory ViewHorseScreen.forDesignTime() {
    Horse designTimeHorse = Horse(name: 'DesignTimeHorse');
    HorseDb designTimeDb = HorseDb(dbName: 'designTimeDb');
    return new ViewHorseScreen(horse: designTimeHorse, horseDb: designTimeDb);
  }
}

class _ViewHorseScreenState extends State<ViewHorseScreen> {
  _ViewHorseScreenState({@required this.horse, @required this.horseDb}) {
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
      _buildDropdownButtonFieldWidget<Gender>(
          labelText: s.gender,
          items: genderStrings,
          value: horse.gender,
          context: c,
          callback: (gender) {
            final h = Horse.fromGender(horse, gender);
            horseDb.replace(horse, h);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Event event;
          EventWidget(event: event);
        },
        tooltip: s.add_event,
        child: Icon(Icons.add),
      ),
      drawer: PferdepassDrawer(horseDb: horseDb),
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
        key, DropdownMenuItem(value: key, child: Text(value(S.of(context))))));

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

  String toLocalizedString(BuildContext context) => horse.ueln.toString();

  final Horse horse;
  final HorseDb horseDb;
}

typedef _HorseCallback<T> = T Function(T);
