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

import 'package:Pferdepass/backend/horse.dart';
import 'package:Pferdepass/backend/horseDB.dart';
import 'package:Pferdepass/backend/tools.dart';
import 'package:Pferdepass/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'pferdepass_icons.dart';
import 'viewhorse.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  factory MainScreen.forDesignTime() {
    return new MainScreen();
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var horseDb = HorseDb();
  var versionName = '';
  var versionCode = '';

  _MainScreenState();

  @override
  void initState() {
    super.initState();
    // asynchronously load the database file and version informations
    HorseDb().loadDb().then((horseDb) => setState(() => horseDb = horseDb));
    PackageInfo.fromPlatform().then((packageInfo) => setState(() {
          versionName = packageInfo.version;
          versionCode = packageInfo.buildNumber;
        }));
  }

  @override
  Widget build(BuildContext c) {
    List<HorseCard> horseCards = [];
    var s = S.of(c);

    for (final h in horseDb.horses) {
      horseCards.add(HorseCard(
        horse: h,
        horseDb: horseDb,
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(s.title),
      ),
      body: Center(
        child: ListView(children: horseCards),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final h = await showDialog<Horse>(
              context: c,
              builder: (BuildContext c) => _addHorseDialogBuilder(c));
          setState(() => h != null ? horseDb.add(h) : null);
        },
        tooltip: s.add_horse,
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        DrawerHeader(
            child: FittedBox(
                child: Icon(Pferdepass.pferdepass), fit: BoxFit.contain)),
        ListTile(
          title: Text(s.my_horses),
        ),
        ListTile(
          title: Text(s.events),
        ),
        AboutListTile(
          applicationIcon: Icon(Pferdepass.pferdepass),
          applicationName: s.title,
          applicationVersion: versionName + versionCode,
          applicationLegalese: legalese,
        )
      ])),
    );
  }

  Widget _addHorseDialogBuilder(BuildContext c) {
    final s = S.of(c);
    final horse = Horse(); // create the new horse, empty for now
    // create the dialog to fill the horse's names
    return SimpleDialog(
        title: Text(s.input_names),
        contentPadding: EdgeInsets.all(8.0),
        children: <Widget>[
          Container(
            width: double.maxFinite,
            height: 130.0,
            child: ListView(children: <Widget>[
              TextField(
                  controller: TextEditingController(text: horse.name),
                  decoration: InputDecoration(hintText: s.name_expl),
                  onChanged: (name) => setState(() => horse.name = name)),
              TextField(
                  controller: TextEditingController(text: horse.sportsName),
                  decoration: InputDecoration(hintText: s.sportsname_expl),
                  onChanged: (sportsName) =>
                      setState(() => horse.sportsName = sportsName)),
              TextField(
                  controller: TextEditingController(text: horse.breedName),
                  decoration: InputDecoration(hintText: s.breedname_expl),
                  onChanged: (breedName) =>
                      setState(() => horse.breedName = breedName)),
            ]),
          ),
          Container(
            width: double.maxFinite,
            child: Row(children: <Widget>[
              FlatButton(
                  child: Text(s.cancel),
                  onPressed: () => Navigator.pop(c, null)),
              Expanded(child: Container()),
              RaisedButton(
                child: Text(s.finish),
                onPressed: () => Navigator.pop(c, horse),
              ),
            ]),
          ),
        ]);
  }
}

class HorseCard extends StatefulWidget {
  @override
  _HorseCardState createState() =>
      _HorseCardState(horse: horse, horseDb: horseDb);

  HorseCard({this.horse, this.horseDb});

  final Horse horse;
  final HorseDb horseDb;
}

class _HorseCardState extends State<HorseCard> {
  @override
  Widget build(BuildContext context) {
    var nameList = [horse.breedName, horse.sportsName];
    nameList.remove(null);
    var additionalNames = nameList.join(', ');
    if (additionalNames.isNotEmpty)
      additionalNames = '($additionalNames)';
    else
      additionalNames = null;

    return Card(
      child: ListTile(
        // TODO: Horse profile pic here
        leading:
            FittedBox(child: Icon(Pferdepass.pferdepass), fit: BoxFit.contain),
        title: Text(horse?.name ?? ''),
        trailing: () {
          return additionalNames != null ? Text(additionalNames) : null;
        }(),
        subtitle: Text(horse.description(context)),
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewHorse(horse: horse, horseDb: horseDb),
              ),
            ),
      ),
    );
  }

  _HorseCardState({this.horse, this.horseDb});

  final Horse horse;
  final HorseDb horseDb;
}

void addHorseToMainScreen(State<MainScreen> state, Horse horse) {
  if (state is _MainScreenState) state.setState(() => state.horseDb.add(horse));
}
