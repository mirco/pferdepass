import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pferdepass/backend/gender.dart';
import 'package:pferdepass/backend/tools.dart';
import 'package:pferdepass/backend/ueln.dart';
import 'package:pferdepass/generated/i18n.dart';

part 'horse.g.dart';
// needed for JSON serialization code generator

enum Race {
  unknown,
  hannoveranian,
  holsteinian,
  westfalian,
}

Map<Race, LocalizedString> raceStrings = {
  Race.unknown: (BuildContext context) => S.of(context).unknown,
  Race.hannoveranian: (BuildContext context) => S.of(context).hannoveranian,
  Race.holsteinian: (BuildContext context) => S.of(context).holsteinian,
  Race.westfalian: (BuildContext context) => S.of(context).westfalian,
};

enum Color {
  unknown,
  black,
  brown,
  chestnut,
  grey,
}

Map<Color, LocalizedString> colorStrings = {
  Color.unknown: (BuildContext c) => S.of(c).unknown,
  Color.black: (BuildContext c) => S.of(c).black,
  Color.brown: (BuildContext c) => S.of(c).brown,
  Color.chestnut: (BuildContext c) => S.of(c).chestnut,
  Color.grey: (BuildContext c) => S.of(c).grey,
};

@JsonSerializable()
class Horse {
  Ueln ueln;
  String name;
  String sportsName;
  String breedName;
  Gender gender;
  DateTime dateOfBirth;
  Horse father;
  Horse mother;
  Race race;
  Color color;

//  var events; TODO: implement events, contains measurements as well.
//  Map<dynamic, List<Person>> persons; TODO: implement connected persons

  Horse(
      {this.ueln,
      this.name = '',
      this.sportsName,
      this.breedName,
      this.gender = const Gender(),
      this.dateOfBirth,
      this.father,
      this.mother,
      this.race,
      this.color});

  Horse.fromName(String name) : this(name: name);

  Horse.fromUELN(Ueln ueln) : this(ueln: ueln);

  get age => dateOfBirth != null ? getCurrentAge(dateOfBirth) : null;

  factory Horse.fromJson(Map<String, dynamic> json) => _$HorseFromJson(json);

  Map<String, dynamic> toJson() => _$HorseToJson(this);

  String description(BuildContext c) {
    String result = '';
    var s = S.of(c);
    if (age >= 2) {
      if (gender != null && gender.gender == genderType.mare)
        result += s.years_old_female(ageToLocalizedPlural(age));
      else if (gender == null || gender.gender == genderType.unknown)
        result += s.years_old(ageToLocalizedPlural(age));
      else
        result += s.years_old_male(ageToLocalizedPlural(age));
      result += ' ';
    }
    if (color != null) result += '${colorStrings[color](c)} ';
    if (age < 2) {
      if (gender != null && gender.gender == genderType.mare)
        result += s.years_old_female(ageToLocalizedPlural(age));
      else if (gender == null || gender.gender == genderType.unknown)
        result += s.years_old(ageToLocalizedPlural(age));
      else
        result += s.years_old_male(ageToLocalizedPlural(age));
      result += ' ';
    } else if (gender != null && gender.gender != genderType.unknown)
      result += '${Gender.genderStrings[gender.gender](c)} ';
    if (father != null && father.name != null)
      result += '${s.by} ${father.name} ';
    if (mother != null && mother.name != null) {
      result += '${s.out_of} mother.name ';
      if (mother.father != null && mother.father.name != null)
        result += '${s.by} ${mother.father.name}';
    }
    return result;
  }
}
