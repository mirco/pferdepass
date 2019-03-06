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

  List<Horse> get horses => horseDb.data;
}
