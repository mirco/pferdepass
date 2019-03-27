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

import 'horse.dart';
import 'jsonDb.dart';

class HorseDb {
  static const String defaultDbName = "horses.db";
  final JsonDb horseDb;

  HorseDb({String dbName = defaultDbName})
      : horseDb = JsonDb<Horse>(
            dbFile: JsonDb.createDbFile(dbName: dbName),
            fromJson: (Map<String, dynamic> json) => Horse.fromJson(json),
            toJson: (Horse h) => h.toJson());

  Future<HorseDb> loadDb() async {
    await horseDb.loadDb();
    return this;
  }

  void saveDb() async {
    await horseDb.saveDb();
  }

  void add(Horse horse) {
    horseDb.add(horse);
    saveDb();
  }

  void remove(Horse horse) {
    horseDb.remove(horse);
    saveDb();
  }

  void replace(Horse original, Horse updated) {
    horseDb.replace(original, updated);
    saveDb();
  }

  List<Horse> get horses => horseDb.data;
}
