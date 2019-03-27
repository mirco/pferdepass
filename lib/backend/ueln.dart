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

import 'ueln_database.dart';

class Ueln {
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

  static String uelnToString(Ueln u) => u.ueln;
  static Ueln uelnFromString(String s) => Ueln.fromString(s);

  bool operator ==(other) => other is Ueln && ueln == other.ueln;

  int get hashCode => ueln.hashCode;
}
