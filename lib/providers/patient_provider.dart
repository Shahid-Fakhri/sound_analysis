// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper with ChangeNotifier {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String tableName = 'patientTable';
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
    final db = await openDatabase(path, version: 1, onCreate: _createTable);
    return db;
  }

  void _createTable(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tableName (id TEXT PRIMARY KEY NOT NULL, name TEXT NOT NULL,email TEXT NOT NULL,cnic TEXT NOT NULL, age TEXT NOT NULL, phone TEXT NOT NULL, gender TEXT NOT NULL)");
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

  Future<void> deleteRecord(String id) async {
    Database db = await database;
    await db.delete(tableName, where: 'id=?', whereArgs: [id]);
    notifyListeners();
  }

  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> counted =
        await db.rawQuery('SELECT COUNT (*) FROM $tableName');
    final result = Sqflite.firstIntValue(counted);
    return result;
  }
}
