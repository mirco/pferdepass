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
import 'package:json_annotation/json_annotation.dart';
import 'package:pferdepass/generated/i18n.dart';

import 'defaultValues.dart';
import 'event.dart';
import 'gender.dart';
import 'tools.dart';
import 'ueln.dart';

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

@JsonSerializable(includeIfNull: false)
class Horse {
  @JsonKey(nullable: false)
  int id;
  @JsonKey(toJson: Ueln.uelnToString, fromJson: Ueln.uelnFromString)
  Ueln ueln;
  String name = '';
  String sportsName;
  String breedName;
  Gender gender;
  DateTime dateOfBirth;
  int fatherId;
  int motherId;
  Race race;
  Color color;
  List<Event> events = <Event>[];
  @JsonKey(fromJson: durationFromDays, toJson: durationToDays)
  Duration farrierInterval = defaultFarrierInterval;
  bool primaryVaccinationFinished;

  //  Map<dynamic, List<Person>> persons; TODO: implement connected persons
  static Map<int, Horse> horseDb = {};

  Horse(
      {this.id,
      this.ueln,
      this.name,
      this.sportsName,
      this.breedName,
      this.gender,
      this.dateOfBirth,
      this.fatherId,
      this.motherId,
      this.race,
      this.color,
      this.events,
      this.farrierInterval,
      this.primaryVaccinationFinished}) {this.gender ??= Gender(gender: genderType.unknown);}

  factory Horse.fromName(String name) => Horse(name: name);

  factory Horse.fromUELN(Ueln ueln) => Horse(ueln: ueln);

  get age => dateOfBirth != null ? getCurrentAge(dateOfBirth) : null;
  get father => horseDb[fatherId];
  get mother => horseDb[motherId];

  factory Horse.fromJson(Map<String, dynamic> json) => _$HorseFromJson(json);

  Map<String, dynamic> toJson() => _$HorseToJson(this);

  bool operator ==(other) {
    return other is Horse &&
        id == other.id &&
        ueln == other.ueln &&
        name == other.name &&
        sportsName == other.sportsName &&
        breedName == other.breedName &&
        gender == other.gender &&
        dateOfBirth == other.dateOfBirth &&
        fatherId == other.fatherId &&
        motherId == other.motherId &&
        race == other.race &&
        color == other.color &&
        events == other.events &&
        farrierInterval == other.farrierInterval &&
        primaryVaccinationFinished == other.primaryVaccinationFinished;
  }

  int get hashCode => id ?? 0;

  // TODO: change horse description generator
  // this is realy ugly and probably doesn't translate well either
  String description(BuildContext c) {
    String result = '';
    var s = S.of(c);
    if (age != null && age >= 2) {
      if (gender != null && gender == mare)
        result += s.years_old_female(ageToLocalizedPlural(age));
      else if (gender == null || gender.gender == genderType.unknown)
        result += s.years_old(ageToLocalizedPlural(age));
      else
        result += s.years_old_male(ageToLocalizedPlural(age));
      result += ' ';
    }
    if (color != null) result += '${colorStrings[color](c)} ';
    if (age != null && age < 2) {
      if (gender != null && gender == mare)
        result += s.years_old_female(ageToLocalizedPlural(age));
      else if (gender == null || gender.gender == genderType.unknown)
        result += s.years_old(ageToLocalizedPlural(age));
      else
        result += s.years_old_male(ageToLocalizedPlural(age));
      result += ' ';
    } else if (gender != null &&
        gender.gender != genderType.unknown &&
        gender.gender != null)
      result += '${Gender.genderStrings[gender.gender](c)} ';
    if (father != null && father.name != null)
      result += '${s.by} ${father.name} ';
    if (mother != null && mother.name != null) {
      result += '${s.out_of} ${mother.name} ';
      if (mother.father != null && mother.father.name != null)
        result += '${s.by} ${mother.father.name}';
    }
    return result;
  }
}
