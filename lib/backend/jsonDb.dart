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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class JsonDb<T> {
  List<T> data = <T>[];
  Future<File> dbFile;
  bool _loaded = false;
  T Function(Map<String, dynamic>) fromJson;
  Map<String, dynamic> Function(T) toJson;

  JsonDb(
      {@required this.dbFile, @required this.fromJson, @required this.toJson});

  Future<JsonDb<T>> loadDb() async {
    final file = await dbFile;
    String jsonString = await file.readAsString();
    var jsonList = jsonDecode(jsonString);
    for (final json in jsonList) {
      data.add(fromJson(json));
    }
    _loaded = true;
    return this;
  }

  Future<void> saveDb() async {
    String jsonString = '[';
    for (final d in data) {
      if (data.indexOf(d) != 0) jsonString += ',';
      var jsonMap = toJson(d);
      jsonString += jsonEncode(jsonMap);
    }
    jsonString += ']';
    final file = await dbFile;

    // do not save if we haven't loaded the file yet
    if (_loaded) await file.writeAsString(jsonString);
  }

  void add(T value) {
    data.add(value);
    saveDb();
  }

  void remove(T value) {
    data.remove(value);
    saveDb();
  }

  void replace(T original, T updated) {
    final index = data.indexOf(original);
    if (index < 0)
      throw FormatException('${original.toString()} not found in database');

    data[index] = updated;
  }

  static Future<File> createDbFile({String dbName}) async {
    Directory directory;
    try {
      directory = await getApplicationDocumentsDirectory();
    } on MissingPluginException {
      directory = Directory('/tmp');
    }

    return File('${directory.path}/$dbName');
  }
}
