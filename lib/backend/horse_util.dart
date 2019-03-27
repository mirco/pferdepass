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

enum Race {
  unknown,
  hannoveranian,
  holsteinian,
  westfalian,
}

typedef LocalizedString = String Function(S s);

Map<Race, LocalizedString> raceStrings = {
  Race.unknown: (S s) => s.unknown,
  Race.hannoveranian: (S s) => s.hannoveranian,
  Race.holsteinian: (S s) => s.holsteinian,
  Race.westfalian: (S s) => s.westfalian,
};

enum Color {
  unknown,
  black,
  brown,
  chestnut,
  grey,
}

Map<Color, LocalizedString> colorStrings = {
  Color.unknown: (S s) => s.unknown,
  Color.black: (S s) => s.black,
  Color.brown: (S s) => s.brown,
  Color.chestnut: (S s) => s.chestnut,
  Color.grey: (S s) => s.grey,
};

enum Gender {
  unknown,
  stallion,
  mare,
  gelding,
}

const Gender mare = Gender.mare;
const Gender stallion = Gender.stallion;
const Gender gelding = Gender.gelding;

Map<Gender, LocalizedString> genderStrings = {
  Gender.unknown: (S s) => s.unknown,
  Gender.mare: (S s) => s.mare,
  Gender.stallion: (S s) => s.stallion,
  Gender.gelding: (S s) => s.gelding,
};
