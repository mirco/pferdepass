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

import 'dart:convert';

import 'package:pferdepass/backend/gender.dart';
import 'package:pferdepass/backend/horse.dart';
import 'package:pferdepass/backend/ueln.dart';
import 'package:test/test.dart';

final id = 1;
final ueln = Ueln.fromString('DEU456789012345');
const name = 'horsename';
const sportsname = 'sportsname';
const breedname = 'breedname';
const gender = stallion;
final dateOfBirth = DateTime.now();
const fatherId = 123;
const motherId = 234;
const race = Race.hannoveranian;
const color = Color.black;
const farrierInterval = Duration(days: 7 * 8);
const primaryVaccinationFinished = true;

void main() {
  group('Horse', () {
    Horse horse;
    Horse horseNoValues;
    setUp(() {
      horse = Horse(
        id: id,
        ueln: ueln,
        name: name,
        sportsName: sportsname,
        breedName: breedname,
        gender: gender,
        dateOfBirth: dateOfBirth,
        fatherId: fatherId,
        motherId: motherId,
        race: race,
        color: color,
        farrierInterval: farrierInterval,
        primaryVaccinationFinished: primaryVaccinationFinished,
      );
      horseNoValues = Horse();
    });
    test('constructor test', () {
      expect(horse.id, equals(id));
      expect(horse.ueln, equals(ueln));
      expect(horse.name, equals(name));
      expect(horse.sportsName, equals(sportsname));
      expect(horse.breedName, equals(breedname));
      expect(horse.gender, equals(gender));
      expect(horse.dateOfBirth, equals(dateOfBirth));
      expect(horse.fatherId, equals(fatherId));
      expect(horse.motherId, equals(motherId));
      expect(horse.race, equals(race));
      expect(horse.color, equals(color));
      expect(horse.farrierInterval, equals(farrierInterval));
      expect(
          horse.primaryVaccinationFinished, equals(primaryVaccinationFinished));
      expect(horseNoValues.id, equals(null));
      expect(horseNoValues.ueln, equals(null));
      expect(horseNoValues.name, equals(null));
      expect(horseNoValues.sportsName, equals(null));
      expect(horseNoValues.breedName, equals(null));
      expect(horseNoValues.gender, equals(Gender(gender: genderType.unknown)));
      expect(horseNoValues.dateOfBirth, equals(null));
      expect(horseNoValues.fatherId, equals(null));
      expect(horseNoValues.motherId, equals(null));
      expect(horseNoValues.race, equals(null));
      expect(horseNoValues.color, equals(null));
      expect(horseNoValues.farrierInterval, equals(null));
      expect(horseNoValues.primaryVaccinationFinished, equals(null));
    });
    test('operator test', () {
      Horse horse2 = Horse(name: 'different horse');
      Horse horse3 = Horse(
        id: id,
        ueln: ueln,
        name: name,
        sportsName: sportsname,
        breedName: breedname,
        gender: gender,
        dateOfBirth: dateOfBirth,
        fatherId: fatherId,
        motherId: motherId,
        race: race,
        color: color,
        farrierInterval: farrierInterval,
        primaryVaccinationFinished: primaryVaccinationFinished,
      );
      Horse horse4 = Horse(
        id: id,
        ueln: ueln,
        name: name,
        sportsName: sportsname,
        breedName: breedname,
        gender: gender,
        dateOfBirth: dateOfBirth,
        fatherId: fatherId,
        motherId: motherId,
        race: race,
        color: color,
        farrierInterval: farrierInterval,
        primaryVaccinationFinished: primaryVaccinationFinished,
      );

      expect(horse, equals(horse)); // equal to itself
      expect(
          [horse, horse, horse3],
          equals([
            horse3,
            horse4,
            horse4
          ])); // if h1 == h2 and h2 == h3 then h1 == h3
      expect(horse, isNot(equals(horse2)));
      expect(horse3, isNot(equals(horse2)));
    });
    test('getter test', () {
      Horse father = Horse(id: fatherId), mother = Horse(id: motherId);
      expect(horse.age, isZero);
      expect(horse.father, isNull);
      expect(horse.mother, isNull);

      Horse.horseDb[horse.id] = horse;
      Horse.horseDb[father.id] = father;
      Horse.horseDb[mother.id] = mother;

      expect(horse.father, same(father));
      expect(horse.mother, same(mother));
    });
    test('json serialization test', () {
      final serialized = jsonEncode(horse.toJson());
      final deserialized = Horse.fromJson(jsonDecode(serialized));
      expect(deserialized, equals(horse));
    });
  });
}
