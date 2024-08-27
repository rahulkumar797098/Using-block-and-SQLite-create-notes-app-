import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/notes_model.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static const String notesTable = "notesTable";
  static const String columnId = "id";
  static const String columnTitle = "title";
  static const String columnMessage = "message";

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _openDb();
    return _database!;
  }

  Future<Database> _openDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appDirectory.path, "notes.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE $notesTable ("
            "$columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$columnTitle TEXT, "
            "$columnMessage TEXT"
            ")");
      },
    );
  }

  Future<int> addNotes(NotesModel notes) async {
    final db = await _db;
    return await db.insert(notesTable, notes.toMap());
  }

  Future<List<NotesModel>> getAllNotes() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(notesTable);
    return List.generate(maps.length, (i) {
      return NotesModel.fromMap(maps[i]);
    });
  }

  Future<int> updateNotes(NotesModel notes) async {
    final db = await _db;
    return await db.update(
      notesTable,
      notes.toMap(),
      where: '$columnId = ?',
      whereArgs: [notes.id],
    );
  }

  Future<int> deleteNotes(int id) async {
    final db = await _db;
    return await db.delete(
      notesTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
