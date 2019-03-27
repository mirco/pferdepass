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

import 'tools.dart';

enum Race {
  unknown,
  hannoveranian,
  holsteinian,
  westfalian,
}

Map<Race, LocalizedString> raceStrings = {
  Race.unknown: (context) => S.of(context).unknown,
  Race.hannoveranian: (context) => S.of(context).hannoveranian,
  Race.holsteinian: (context) => S.of(context).holsteinian,
  Race.westfalian: (context) => S.of(context).westfalian,
};

enum Color {
  unknown,
  black,
  brown,
  chestnut,
  grey,
}

Map<Color, LocalizedString> colorStrings = {
  Color.unknown: (context) => S.of(context).unknown,
  Color.black: (context) => S.of(context).black,
  Color.brown: (context) => S.of(context).brown,
  Color.chestnut: (context) => S.of(context).chestnut,
  Color.grey: (context) => S.of(context).grey,
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
  Gender.unknown: (context) => S.of(context).unknown,
  Gender.mare: (context) => S.of(context).mare,
  Gender.stallion: (context) => S.of(context).stallion,
  Gender.gelding: (context) => S.of(context).gelding,
};
