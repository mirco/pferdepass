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
import 'package:Pferdepass/backend/horseDB.dart';
import 'package:Pferdepass/backend/tools.dart';
import 'package:Pferdepass/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'pferdepass_icons.dart';
import 'routes.dart';

class PferdepassDrawer extends StatefulWidget {
  final HorseDb horseDb;

  PferdepassDrawer({@required this.horseDb});

  State<PferdepassDrawer> createState() =>
      _PferdepassDrawerState(horseDb: horseDb);
}

class _PferdepassDrawerState extends State<PferdepassDrawer> {
  String versionName, versionCode;
  final HorseDb horseDb;

  _PferdepassDrawerState({this.horseDb});

  void initState() {
    super.initState();
    // asynchronously load the database file and version informations
    PackageInfo.fromPlatform().then((packageInfo) => setState(() {
          versionName = packageInfo.version;
          versionCode = packageInfo.buildNumber;
        }));
  }

  Widget build(BuildContext context) {
    final s = S.of(context);

    return Drawer(
        child: ListView(children: <Widget>[
      DrawerHeader(
          child: FittedBox(
              child: Icon(Pferdepass.pferdepass), fit: BoxFit.contain)),
      ListTile(
        title: Text(s.my_horses),
        onTap: () {
          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
        },
      ),
      ListTile(
        title: Text(s.events),
        onTap: () {
          // all events in historical order
          List<Event> events;
          for (final horse in horseDb.horses) events.addAll(horse.events);
          events.sort((a, b) => a.date.compareTo(b.date));
          Navigator.pushNamed(context, eventRouteName, arguments: events);
        },
      ),
      AboutListTile(
        applicationIcon: Icon(Pferdepass.pferdepass),
        applicationName: s.title,
        applicationVersion: versionName + versionCode,
        applicationLegalese: legalese,
      )
    ]));
  }
}
