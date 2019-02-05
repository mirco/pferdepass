import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart' show BuildContext;

import 'tools.dart';

part 'ueln.g.dart';

@JsonSerializable()
class Ueln extends Localized{
  String ueln;

  Ueln();

  Ueln.fromString(this.ueln) {
    if (!_isUeln(ueln)) throw FormatException("not a valid UELN: $ueln");
  }

  factory Ueln.fromJson(Map<String, dynamic> json) => _$UelnFromJson(json);

  Map<String, dynamic> toJson() => _$UelnToJson(this);

  String toString() => ueln;
  String toLocalizedString(BuildContext context) => ueln;
}

// only checks length for now. TODO: more validity checks for isUeln()
bool _isUeln(String u) {
  if (u.length != 15) return false;
  return true;
}
