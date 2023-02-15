// ignore_for_file: prefer_conditional_assignment, avoid_print
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String tableName = 'patientTable';
  String audioTableName = 'audioTable';
  String databaseName = 'sound_analysis_db.db';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initiatizeDatabase();
    }
    return _database;
  }

  Future<Database> initiatizeDatabase() async {
    final directory = await getApplicationDocumentsDirectory();

    final path = join(directory.path, databaseName);
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: _createTable,
      onConfigure: _configure,
    );

    return db;
  }

  void _configure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  void _createTable(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName (id TEXT PRIMARY KEY NOT NULL, name TEXT NOT NULL,email TEXT NOT NULL,cnic TEXT NOT NULL, age TEXT NOT NULL, phone TEXT NOT NULL, gender TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE $audioTableName(audioId TEXT PRIMARY KEY NOT NULL, id TEXT NOT NULL, file TEXT NOT NULL, FOREIGN KEY (id) REFERENCES $tableName (id) ON DELETE SET NULL)");
    print('creating tables.....');
  }

  Future<void> deleteTable() async {
    Database db = await database;
    final result = await db.delete(audioTableName);
    print('Table deleting response: $result');
  }

  Future<List<Map<String, dynamic>>> fetchPatient() async {
    Database db = await database;
    final result = await db.query(tableName, orderBy: 'id');
    return result;
  }

  Future<int> insertData(Map<String, String> patient) async {
    Database db = await database;
    final result = await db.insert(tableName, patient);
    return result;
  }

  Future<List<Map<String, dynamic>>> fetchData(String id) async {
    Database db = await database;
    final data = await db.query(tableName, where: 'id=?', whereArgs: [id]);
    return data;
  }

  Future<int> updateRecord(Map<String, String> editedRecord) async {
    Database db = await database;
    final result = await db.update(tableName, editedRecord,
        where: 'id=?', whereArgs: [editedRecord['id']]);
    return result;
  }

  Future<int> deleteRecord(String id) async {
    Database db = await database;
    final result = await db.delete(tableName, where: 'id=?', whereArgs: [id]);
    return result;
  }

  Future<int> insertAudio(Map<String, String> audio) async {
    Database db = await database;
    final result = await db.insert(audioTableName, audio,
        conflictAlgorithm: ConflictAlgorithm.ignore);
    return result;
  }

  Future<List<Map<String, dynamic>>> fetchAudio(String id) async {
    Database db = await database;
    final data = await db.query(audioTableName, where: 'id=?', whereArgs: [id]);
    return data;
  }

  Future<int> deleteAudio(String id) async {
    Database db = await database;
    final result =
        await db.delete(audioTableName, where: 'audioId=?', whereArgs: [id]);
    return result;
  }

  Future<void> deleteDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    databaseFactory.deleteDatabase(join(dir.path, databaseName));
  }

  void close() async {
    await _database.close();
  }
}
