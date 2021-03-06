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

import 'package:json_annotation/json_annotation.dart';
import 'package:Pferdepass/backend/horse.dart';

part 'person.g.dart';
//import 'package:contacts_service/contacts_service.dart';

@JsonSerializable()
class Person {
  String name;
  String prename;
  List<Horse> horses;

//  Contact contact;

  Person();

  Person.fromName(String prename, String name)
      : this.prename = prename,
        this.name = name;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class PersonType {
  String toString() {
    return _strings[_state];
  }

  PersonType() : _state = _PersonType.unknown;

  PersonType.fromString(String s) {
    if (!_strings.containsValue(s)) throw FormatException;
    _strings.forEach(
        (var key, var value) => value == s ? _state = key : _state = _state);
  }

  factory PersonType.fromJson(Map<String, dynamic> json) =>
      _$PersonTypeFromJson(json);

  Map<String, dynamic> toJson() => _$PersonTypeToJson(this);

  static const Map<dynamic, String> _strings = {
    _PersonType.unknown: 'unknown',
    _PersonType.owner: 'owner',
    _PersonType.vet: 'veterinarian',
    _PersonType.farrier: 'farrier',
    _PersonType.groom: 'groom',
    _PersonType.rider: 'rider',
    _PersonType.saddler: 'saddler'
  };
  _PersonType _state;
}

enum _PersonType {
  unknown,
  owner,
  vet,
  farrier,
  groom,
  rider,
  saddler,
}
