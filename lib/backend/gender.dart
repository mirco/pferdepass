import 'package:flutter/material.dart' show BuildContext;
import 'package:json_annotation/json_annotation.dart';
import "package:pferdepass/generated/i18n.dart";

import 'tools.dart';

part 'gender.g.dart';

enum genderType {
  unknown,
  stallion,
  mare,
  gelding,
}

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

  const Gender({this.gender = genderType.unknown, this.dateOfCastration});

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);

  Map<String, dynamic> toJson() => _$GenderToJson(this);
}
