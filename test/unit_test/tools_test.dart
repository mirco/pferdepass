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

import 'package:pferdepass/backend/tools.dart';
import 'package:test/test.dart';

void main() {
  test('dateformatter test', () {
    final date = DateTime(2019, 3, 6);
    final formatted = formatDate(date);
    expect(formatted, '6.3.2019');
  });
  test('current age from birthdate test', () {
    final date = DateTime.now();
    final age = getCurrentAge(date);
    expect(age, 0);
    final date2 = date.add(durationFromDays(-365));
    final age2 = getCurrentAge(date2);
    expect(age2, 1);
  });
}
