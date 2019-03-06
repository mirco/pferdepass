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
    });
    test('constructor tests', () {
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
    });
    test('operator tests', () {
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
    test('getter tests', () {
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
    test('json serialization', () {
      final serialized = jsonEncode(horse.toJson());
      final deserialized = Horse.fromJson(jsonDecode(serialized));
      expect(deserialized, equals(horse));
    });
  });
}
