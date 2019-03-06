import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
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

  static Future<File> createDbFile({String dbName}) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$dbName');
  }
}
