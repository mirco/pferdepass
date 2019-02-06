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

var _dateFormatter = DateFormat('dd.MM.yyyy');

String formatDate(DateTime date){
  if(date != null)
    return _dateFormatter.format(date);
  else
    return null;
}

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

