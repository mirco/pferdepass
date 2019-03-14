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

import 'package:Pferdepass/generated/i18n.dart' as i18n;
import 'package:Pferdepass/ui/dateTimePicker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DateTimePicker', () {
    DateTime date;
    setUp(() {
      date = DateTime(2011, 11, 11);
    });
    testWidgets('construction test', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DateTimePicker(
            selectedDate: date,
            onSelectDate: (d) => tester
                .firstState(find.byType(DateTimePicker))
                .setState(() => date = d),
            labelText: 'testDate'),
        localizationsDelegates: const [
          i18n.S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: i18n.S.delegate.supportedLocales,
      ));
      expect(find.byType(DateTimePicker), findsOneWidget);
      final button = find.byType(FlatButton);
      await tester.tap(button);
      await tester.pump();
      expect(find.byType(YearPicker), findsOneWidget);
    });
  });
}
