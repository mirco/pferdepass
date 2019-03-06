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

import 'package:flutter/material.dart' show BuildContext;
import 'package:json_annotation/json_annotation.dart';
import 'package:pferdepass/generated/i18n.dart';

import 'tools.dart';

part 'gender.g.dart';

enum genderType {
  unknown,
  stallion,
  mare,
  gelding,
}

const Gender stallion = Gender.constant(genderType.stallion);
const Gender mare = Gender.constant(genderType.mare);
const Gender gelding = Gender.constant(genderType.gelding);

@JsonSerializable()
class Gender extends Localized {
  final genderType gender;
  final DateTime dateOfCastration;

  static Map<genderType, LocalizedString> genderStrings = {
    genderType.unknown: (BuildContext c) => S.of(c).unknown,
    genderType.stallion: (BuildContext c) => S.of(c).stallion,
    genderType.mare: (BuildContext c) => S.of(c).mare,
    genderType.gelding: (BuildContext c) => S.of(c).gelding,
  };

  String toLocalizedString(BuildContext context) {
    assert(genderStrings.keys.contains(gender));
    return genderStrings[gender](context);
  }

  const Gender.constant(this.gender) : dateOfCastration = null;

  Gender({this.gender, this.dateOfCastration}) {
    if (gender != genderType.gelding && dateOfCastration != null)
      throw FormatException('Error: only geldings can be castrated');
  }

  factory Gender.update({Gender gender, DateTime dateOfCastration}) {
    return Gender(gender: gender.gender, dateOfCastration: dateOfCastration);
  }

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);

  Map<String, dynamic> toJson() => _$GenderToJson(this);

  bool operator ==(other) =>
      other is Gender &&
      gender == other.gender &&
      dateOfCastration == other.dateOfCastration;

  int get hashCode => gender.index;
}
