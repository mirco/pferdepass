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

import 'package:Pferdepass/backend/horseDB.dart';
import 'package:Pferdepass/generated/i18n.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

class NotFoundScreen extends StatelessWidget {
  final HorseDb horseDb;

  NotFoundScreen({this.horseDb});

  build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).page_not_found),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[],
        ),
        drawer: PferdepassDrawer(
          horseDb: horseDb,
        ),
      );
}
