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
import 'package:Pferdepass/generated/i18n.dart' as i18n;
import 'package:Pferdepass/ui/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainScreen', () {
    Horse horse;
    setUp(() {
      horse = Horse();
    });
    testWidgets('constructor test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MainScreen(),
        localizationsDelegates: const [
          i18n.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: i18n.S.delegate.supportedLocales,
      ));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(HorseCard), findsNothing);

      State<MainScreen> state = tester.firstState(find.byType(MainScreen));
      addHorseToMainScreen(state, horse);
      await tester.pump();

      expect(find.byType(HorseCard), findsOneWidget);
    });
  });
}
