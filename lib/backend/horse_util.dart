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

String _rUnknown(final S s) => s.unknown;
String _rHannoveranian(final S s) => s.hannoveranian;
String _rHolsteinian(final S s) => s.holsteinian;
String _rWestfalian(final S s) => s.westfalian;

Map<Race, LocalizedString> raceStrings = {
  Race.unknown: _rUnknown,
  Race.hannoveranian: _rHannoveranian,
  Race.holsteinian: _rHolsteinian,
  Race.westfalian: _rWestfalian,
};

enum Color {
  unknown,
  black,
  brown,
  chestnut,
  grey,
}

String _cUnknown(final S s) => s.unknown;
String _cBlack(final S s) => s.black;
String _cBrown(final S s) => s.brown;
String _cChestnut(final S s) => s.chestnut;
String _cGrey(final S s) => s.grey;

const Map<Color, LocalizedString> colorStrings = const {
  Color.unknown: _cUnknown,
  Color.black: _cBlack,
  Color.brown: _cBrown,
  Color.chestnut: _cChestnut,
  Color.grey: _cGrey,
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

String _gUnknow(final S s) => s.unknown;
String _gMare(final S s) => s.mare;
String _gStallion(final S s) => s.stallion;
String _gGelding(final S s) => s.gelding;

const Map<Gender, LocalizedString> genderStrings = const {
  Gender.unknown: _gUnknow,
  Gender.mare: _gMare,
  Gender.stallion: _gStallion,
  Gender.gelding: _gGelding,
};
