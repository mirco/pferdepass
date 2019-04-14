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
import 'package:flutter/material.dart';

import 'eventScreen.dart';
import 'mainScreen.dart';
import 'notFoundScreen.dart';
import 'viewHorseScreen.dart';

const initialRouteName = '/';
const eventRouteName = '/events';
const viewHorseRouteName = '/horse';
const horseEventsRouteName = '/horse/events';

MaterialPageRoute onGenerateRoute(RouteSettings settings) {
  assert(settings.arguments is Map<String, dynamic>);
  final arguments = settings.arguments as Map<String, dynamic>;
  assert(arguments['horseDb'] is HorseDb);
  final horseDb = arguments['horseDb'] as HorseDb;
  switch (settings.name) {
    case initialRouteName:
      return MaterialPageRoute(
          builder: (context) => MainScreen(
                horseDb: horseDb,
              ));
      break;
    case eventRouteName:
      return MaterialPageRoute(
        builder: (context) => EventScreen(
              horseDb: horseDb,
              events: arguments['events'],
            ),
      );
      break;
    case viewHorseRouteName:
      return MaterialPageRoute(
        builder: (context) => ViewHorseScreen(
            horseDb: horseDb, horse: arguments['horse'] as Horse),
      );
      break;
    case horseEventsRouteName:
      return MaterialPageRoute(
        builder: (context) => EventScreen(
            horseDb: horseDb, events: (arguments['horse'] as Horse).events),
      );
      break;
    default:
      return onUnknownRoute(settings);
  }
}

MaterialPageRoute onUnknownRoute(RouteSettings settings) => MaterialPageRoute(
    builder: (context) => NotFoundScreen(
          horseDb: (settings.arguments as Map<String, dynamic>)['horseDb']
              as HorseDb,
        ));
