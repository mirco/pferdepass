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

import 'package:Pferdepass/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'defaultValues.dart';
import 'event.dart';
import 'gender.dart';
import 'tools.dart';
import 'ueln.dart';

part 'horse.g.dart';

@JsonSerializable(includeIfNull: false)
class Horse {
  @JsonKey(nullable: false)
  int id;
  @JsonKey(toJson: Ueln.uelnToString, fromJson: Ueln.uelnFromString)
  Ueln ueln;
  String name = '';
  String sportsName;
  String breedName;
  DateTime dateOfBirth;
  int fatherId;
  int motherId;
  Race race;
  Color color;
  List<Event> events = <Event>[];
  @JsonKey(fromJson: durationFromDays, toJson: durationToDays)
  Duration farrierInterval = defaultFarrierInterval;
  bool primaryVaccinationFinished;
  Gender gender;

  //  Map<dynamic, List<Person>> persons; TODO: implement connected persons
  static Map<int, Horse> horseDb = {};

  Horse({
    this.id,
    this.ueln,
    this.name,
    this.sportsName,
    this.breedName,
    this.dateOfBirth,
    this.fatherId,
    this.motherId,
    this.race,
    this.color,
    this.events,
    this.farrierInterval,
    this.primaryVaccinationFinished,
    this.gender = Gender.unknown,
  });

  factory Horse.fromGender(Horse horse, Gender gender) {
    switch (gender) {
      case Gender.stallion:
        return Stallion.fromHorse(horse);
      case Gender.mare:
        return Mare.fromHorse(horse);
      case Gender.gelding:
        return Gelding.fromHorse(horse);
      default:
        horse.gender = gender;
        return horse;
    }
  }

  factory Horse.fromName(String name) => Horse(name: name);

  factory Horse.fromUELN(Ueln ueln) => Horse(ueln: ueln);

  get age => dateOfBirth != null ? getCurrentAge(dateOfBirth) : null;
  get father => horseDb[fatherId];
  get mother => horseDb[motherId];

  factory Horse.fromJson(Map<String, dynamic> json) {
    final gender = json["gender"];
    switch (gender) {
      case Gender.stallion:
        return Stallion.fromJson(json);
      case Gender.mare:
        return Mare.fromJson(json);
      case Gender.gelding:
        return Gelding.fromJson(json);
      default:
        return _$HorseFromJson(json);
    }
  }

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
      else if (gender == null || gender == Gender.unknown)
        result += s.years_old(ageToLocalizedPlural(age));
      else
        result += s.years_old_male(ageToLocalizedPlural(age));
      result += ' ';
    }
    if (color != null) result += '${colorStrings[color](c)} ';
    if (age != null && age < 2) {
      if (gender != null && gender == mare)
        result += s.years_old_female(ageToLocalizedPlural(age));
      else if (gender == null || gender == Gender.unknown)
        result += s.years_old(ageToLocalizedPlural(age));
      else
        result += s.years_old_male(ageToLocalizedPlural(age));
      result += ' ';
    } else if (gender != null && gender != Gender.unknown)
      result += '${genderStrings[gender](c)} ';
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

@JsonSerializable()
class Stallion extends Horse {
  Stallion({
    int id,
    Ueln ueln,
    String name,
    String sportsName,
    String breedName,
    DateTime dateOfBirth,
    int fatherId,
    int motherId,
    Race race,
    Color color,
    List<Event> events,
    Duration farrierInterval,
    bool primaryVaccinationFinished,
  }) : super(
            id: id,
            ueln: ueln,
            name: name,
            sportsName: sportsName,
            breedName: breedName,
            dateOfBirth: dateOfBirth,
            fatherId: fatherId,
            motherId: motherId,
            race: race,
            color: color,
            events: events,
            farrierInterval: farrierInterval,
            primaryVaccinationFinished: primaryVaccinationFinished,
            gender: stallion);

  factory Stallion.fromHorse(Horse horse) => Stallion(
      id: horse.id,
      ueln: horse.ueln,
      name: horse.name,
      sportsName: horse.sportsName,
      breedName: horse.breedName,
      dateOfBirth: horse.dateOfBirth,
      fatherId: horse.fatherId,
      motherId: horse.motherId,
      race: horse.race,
      color: horse.color,
      events: horse.events,
      farrierInterval: horse.farrierInterval,
      primaryVaccinationFinished: horse.primaryVaccinationFinished);

  factory Stallion.fromJson(Map<String, dynamic> json) =>
      _$StallionFromJson(json);
  Map<String, dynamic> toJson() => _$StallionToJson(this);
}

@JsonSerializable()
class Mare extends Horse {
  List<DateTime> insemination = [];

  Mare({
    int id,
    Ueln ueln,
    String name,
    String sportsName,
    String breedName,
    DateTime dateOfBirth,
    int fatherId,
    int motherId,
    Race race,
    Color color,
    List<Event> events,
    Duration farrierInterval,
    bool primaryVaccinationFinished,
    this.insemination,
  }) : super(
            id: id,
            ueln: ueln,
            name: name,
            sportsName: sportsName,
            breedName: breedName,
            dateOfBirth: dateOfBirth,
            fatherId: fatherId,
            motherId: motherId,
            race: race,
            color: color,
            events: events,
            farrierInterval: farrierInterval,
            primaryVaccinationFinished: primaryVaccinationFinished,
            gender: mare);
  factory Mare.fromHorse(Horse horse) => Mare(
      id: horse.id,
      ueln: horse.ueln,
      name: horse.name,
      sportsName: horse.sportsName,
      breedName: horse.breedName,
      dateOfBirth: horse.dateOfBirth,
      fatherId: horse.fatherId,
      motherId: horse.motherId,
      race: horse.race,
      color: horse.color,
      events: horse.events,
      farrierInterval: horse.farrierInterval,
      primaryVaccinationFinished: horse.primaryVaccinationFinished);

  factory Mare.fromJson(Map<String, dynamic> json) => _$MareFromJson(json);
  Map<String, dynamic> toJson() => _$MareToJson(this);
}

@JsonSerializable()
class Gelding extends Horse {
  DateTime dateOfCastration;

  Gelding({
    int id,
    Ueln ueln,
    String name,
    String sportsName,
    String breedName,
    DateTime dateOfBirth,
    int fatherId,
    int motherId,
    Race race,
    Color color,
    List<Event> events,
    Duration farrierInterval,
    bool primaryVaccinationFinished,
    this.dateOfCastration,
  }) : super(
            id: id,
            ueln: ueln,
            name: name,
            sportsName: sportsName,
            breedName: breedName,
            dateOfBirth: dateOfBirth,
            fatherId: fatherId,
            motherId: motherId,
            race: race,
            color: color,
            events: events,
            farrierInterval: farrierInterval,
            primaryVaccinationFinished: primaryVaccinationFinished,
            gender: gelding);

  factory Gelding.fromHorse(Horse horse) => Gelding(
      id: horse.id,
      ueln: horse.ueln,
      name: horse.name,
      sportsName: horse.sportsName,
      breedName: horse.breedName,
      dateOfBirth: horse.dateOfBirth,
      fatherId: horse.fatherId,
      motherId: horse.motherId,
      race: horse.race,
      color: horse.color,
      events: horse.events,
      farrierInterval: horse.farrierInterval,
      primaryVaccinationFinished: horse.primaryVaccinationFinished);

  factory Gelding.fromJson(Map<String, dynamic> json) =>
      _$GeldingFromJson(json);
  Map<String, dynamic> toJson() => _$GeldingToJson(this);
}
