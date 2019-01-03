import 'package:uuid/uuid.dart';

import 'person.dart';
import 'ueln.dart';
import 'sex.dart';

class Horse {
  Uuid id;
  Ueln ueln;
  String name;
  String sportsName;
  String breedName;
  Sex sex;
  DateTime dateOfBirth;
  Horse father;
  Horse mother;
  Race race;
  Color color;
  var events;
  Map<PersonType ,List<Person>> persons;
}

enum Race {
  unknown,
}

enum Color {
  unknown,
}