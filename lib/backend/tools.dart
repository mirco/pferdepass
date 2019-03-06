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
import 'package:intl/intl.dart';

import 'gender.dart';
import 'horse.dart';

// yearwise age as used with horses, i.e. all Horses get one year older on the first of january,
// no matter the actual birthday.
int getCurrentAge(DateTime dateOfBirth) {
  assert(dateOfBirth != null);
  return DateTime.now().year - dateOfBirth.year;
}

var _dateFormatter = DateFormat('d.M.yyyy');

String formatDate(DateTime date) =>
    date != null ? _dateFormatter.format(date) : null;

// function to create a horse object for testing
Horse buildHorse() {
  var h = Horse.fromName('Viva');
  h.color = Color.grey;
  h.gender = Gender(gender: genderType.mare);
  h.dateOfBirth = DateTime(2012, 2, 3); // 3.2.2012
  h.sportsName = 'Viva DH';
  h.race = Race.westfalian;
  return h;
}

String stringOrNull<T>(T v) {
  if (v == null)
    return '';
  else
    return v.toString();
}

typedef LocalizedString = String Function(BuildContext context);

abstract class Localized {
  const Localized();

  String toLocalizedString(BuildContext context);
}

String ageToLocalizedPlural(int age) {
  switch (age) {
    case 0:
      return 'zero';
    case 1:
      return 'one';
    default:
      return age.toString();
  }
}

Duration durationFromDays(int days) => Duration(days: days);
int durationToDays(Duration d) => d?.inDays;
