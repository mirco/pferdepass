import 'package:flutter/material.dart' show BuildContext;

import 'tools.dart';
import 'ueln_database.dart';

class Ueln extends Localized {
  final String ueln;

  const Ueln(this.ueln);

  factory Ueln.fromString(String s) {
    if (s.length != 14 && s.length != 15)
      throw FormatException('Error: <$s> is not a 15 character string');
    s = s.toUpperCase();
    if (s.length == 14)
      s = s.replaceRange(0, 2, '${s.substring(0, 2).toUpperCase()} ');

    if (s.startsWith(RegExp('[0-9]{3}'))) {
      final code = int.parse(s.substring(0, 3));
      s = s.replaceRange(0, 3, uelnCountryCodeAlpha3FromNum(code));
    }
    if (s.startsWith(RegExp('[A-Z]{2} '))) {
      final code = uelnCountryCodeNumFromAlpha2(s.substring(0, 2));
      s = s.replaceRange(0, 3, uelnCountryCodeAlpha3FromNum(code));
    }
    return Ueln(s);
  }

  String toString() => ueln;
  String toLocalizedString(BuildContext context) => ueln;

  static String uelnToString(Ueln u) => u.ueln;
  static Ueln uelnFromString(String s) => Ueln.fromString(s);

  bool operator ==(other) => other is Ueln && ueln == other.ueln;

  int get hashCode => ueln.hashCode;
}
