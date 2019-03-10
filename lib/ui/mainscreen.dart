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

import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pferdepass/backend/horse.dart';
import 'package:pferdepass/backend/horseDB.dart';
import 'package:pferdepass/generated/i18n.dart';

import 'pferdepass_icons.dart';
import 'viewhorse.dart';

class MainScreen extends StatefulWidget {
  MainScreen();

  factory MainScreen.forDesignTime() {
    // TODO: add arguments
    return new MainScreen();
  }

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String versionName;
  String versionCode;

  _MainScreenState();

  @override
  void initState() {
    super.initState();
    // asynchronously load the database file
    HorseDb().loadDb().then((HorseDb value) {
      setState(() {
        horseDb = value;
      });
    });
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        versionName = packageInfo.version;
        versionCode = packageInfo.buildNumber;
      });
    });
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
          setState(() {
            if (h != null) horseDb.add(h);
          });
        },
        tooltip: s.add_horse,
        child: Icon(Icons.add),
      ),
      drawer: Drawer(
          child: ListView(children: <Widget>[
        DrawerHeader(child: Icon(Pferdepass.pferdepass)),
        ListTile(
          title: Text(s.my_horses),
        ),
        AboutListTile(
          applicationIcon: Icon(Pferdepass.pferdepass),
          applicationName: s.title,
          applicationVersion: versionName + versionCode,
          applicationLegalese: '''Copyright Mirco Tischler <mt-ml@gmx.de>

published under the GPL version 3

Icons made by FreePik from flaticons.com''',
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
          Form(
            child: Container(
              width: double.maxFinite,
              height: 256.0,
              child: ListView(children: <Widget>[
                TextFormField(
                    controller: TextEditingController(text: horse.name),
                    decoration: InputDecoration(hintText: s.name_expl),
                    onSaved: (String value) {
                      setState(() {
                        horse.name = value;
                      });
                    }),
                TextFormField(
                    controller: TextEditingController(text: horse.sportsName),
                    decoration: InputDecoration(hintText: s.sportsname_expl),
                    onSaved: (String value) {
                      setState(() {
                        horse.sportsName = value;
                      });
                    }),
                TextFormField(
                    controller: TextEditingController(text: horse.breedName),
                    decoration: InputDecoration(hintText: s.breedname_expl),
                    onSaved: (String value) {
                      setState(() {
                        horse.breedName = value;
                      });
                    }),
              ]),
            ),
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FlatButton(
                    child: Text(s.cancel),
                    onPressed: () {
                      Navigator.pop(c, null);
                    }),
                RaisedButton(
                  child: Text(s.finish),
                  onPressed: () {
                    Navigator.pop(c, horse);
                  },
                ),
              ])
        ]);
  }

  HorseDb horseDb = HorseDb();
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
        leading: Container(
            width: 64.0, height: 64.0, child: Icon(Pferdepass.pferdepass)),
        title: Text(horse.name),
        trailing: () {
          return additionalNames != null ? Text(additionalNames) : null;
        }(),
        subtitle: Text(horse.description(context)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewHorse(horse: horse, horseDb: horseDb),
            ),
          );
        },
      ),
    );
  }

  _HorseCardState({this.horse, this.horseDb});

  final Horse horse;
  final HorseDb horseDb;
}
