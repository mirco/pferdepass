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
import 'package:Pferdepass/backend/horse_util.dart';
import 'package:Pferdepass/generated/i18n.dart' as i18n;
import 'package:Pferdepass/ui/viewHorseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Horse horse;
  HorseDb horseDb;
  setUp(() {
    horse =
        Horse(name: 'name', sportsName: 'sportsName', breedName: 'breedName');
    horseDb = HorseDb();
    horseDb.add(horse);
  });
  group('ViewHorse', () {
    testWidgets('constructor test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ViewHorseScreen(
          horse: horse,
          horseDb: horseDb,
        ),
        localizationsDelegates: const [
          i18n.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: i18n.S.delegate.supportedLocales,
      ));

      expect(find.byType(ViewHorseScreen), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is DropdownButton<Race>),
          findsOneWidget);
      expect(
          find.byWidgetPredicate((widget) => widget is DropdownButton<Color>),
          findsOneWidget);

      expect(
          find.byWidgetPredicate((widget) => widget is DropdownButton<Gender>),
          findsOneWidget);
    });
    testWidgets('callback test', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: ViewHorseScreen(
          horse: horse,
          horseDb: horseDb,
        ),
        localizationsDelegates: const [
          i18n.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: i18n.S.delegate.supportedLocales,
      ));
      var nameFinder = find.byWidgetPredicate((widget) =>
          widget is TextField && widget?.controller?.text == 'name');
      var sportsNameFinder = find.byWidgetPredicate((widget) =>
          widget is TextField && widget?.decoration?.labelText == 'Sportsname');
      var breedNameFinder = find.byWidgetPredicate((widget) =>
          widget is TextField && widget.decoration.labelText == 'Breedname');
      expect(nameFinder, findsOneWidget);
      expect(sportsNameFinder, findsOneWidget);
      expect(breedNameFinder, findsOneWidget);
      expect(horse.name, 'name');
      await tester.enterText(nameFinder, 'testName');
      await tester.enterText(sportsNameFinder, 'testSportsName');
      await tester.enterText(breedNameFinder, 'testBreedName');
      await tester.pump();
      expect(horse.name, 'testName');
      expect(horse.sportsName, 'testSportsName');
      expect(horse.breedName, 'testBreedName');
    });
  });
}
