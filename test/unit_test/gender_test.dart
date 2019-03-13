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
import 'package:test/test.dart';

void main() {
  group('Gender', () {
    Gender g1, g2, g3, g4;
    setUp(() {
      g1 = stallion;
      g2 = mare;
      g3 = gelding;
      g4 = Gender(gender: genderType.gelding, dateOfCastration: DateTime.now());
    });
    test('constructor test', () {
      expect(g1.gender, genderType.stallion);
      expect(g1.dateOfCastration, isNull);
      expect(g2.gender, genderType.mare);
      expect(g2.dateOfCastration, isNull);
      expect(g3.gender, genderType.gelding);
      expect(g3.dateOfCastration, isNull);
      expect(g4.gender, genderType.gelding);
      expect(
          g4.dateOfCastration,
          allOf(isNotNull, TypeMatcher<DateTime>(),
              predicate((DateTime t) => t.isBefore(DateTime.now()))));
      expect(
          () =>
              Gender(gender: genderType.mare, dateOfCastration: DateTime.now()),
          throwsFormatException);
      expect(
          () => Gender(
              gender: genderType.stallion, dateOfCastration: DateTime.now()),
          throwsFormatException);
    });
  });
}
