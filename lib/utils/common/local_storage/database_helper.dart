import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  late Database _database;

  Future<void> initializeDatabase() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE users(mobileNumber TEXT PRIMARY KEY, name TEXT, pin TEXT)',
        );

        db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, mobileNumber TEXT, title TEXT, content TEXT, isFavorite INTEGER, timestamp INTEGER)',
        );
      },
      version: 1,
    );
  }

  // Code for the notes.
  Future<int> addNote({
    required String mobileNumber,
    required String title,
    required String content,
    required bool isFavorite,
  }) async {
  return  await _database.insert(
      'notes',
      {
        'mobileNumber': mobileNumber,
        'title': title,
        'content': content,
        'isFavorite': isFavorite ? 1 : 0,
        'timestamp': getTimestamp(),
      },
    );
  }

  Future<Map<String, dynamic>?> getNoteById(int id) async {
    List<Map<String, dynamic>> notes = await _database.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (notes.isNotEmpty) {
      return notes.first;
    } else {
      return null;
    }
  }

  Future<int> updateNote({
    required String mobileNumber,
    required String title,
    required String content,
    required bool isFavorite,
    required int dbId,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
   return await _database.update(
      'notes',
      {
        'mobileNumber': mobileNumber,
        'title': title,
        'content': content,
        'isFavorite': isFavorite ? 1 : 0,
        'timestamp': timestamp,
      },
      where: 'id = ?',
      whereArgs: [dbId],
    );
  }

  Future<void> deleteNote({
    required int dbId,
  }) async {
    await _database
        .delete('notes', where: 'id = ?', whereArgs: [dbId]);
  }

  Future<List<Map<String, dynamic>>> getNotes({
    required String mobileNumber,
  }) async {
    return await _database
        .query('notes', where: 'mobileNumber = ?', whereArgs: [mobileNumber]);
  }

  // Code for the  users.

  Future<int> addUser({
    required String mobileNumber,
    required String name,
    required String pin,
  }) async {
      int value = await _database.insert(
      'users',
      {'mobileNumber': mobileNumber, 'name': name, 'pin': pin},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return value;
  }

  Future<void> updateUser({
    required String mobileNumber,
    required String name,
    required String pin,
  }) async {
    await _database.update(
      'users',
      {'name': name, 'pin': pin},
      where: 'mobileNumber = ?',
      whereArgs: [mobileNumber],
    );
  }

  Future<void> deleteUser({
    required String mobileNumber,
  }) async {
    await _database.delete(
      'users',
      where: 'mobileNumber = ?',
      whereArgs: [mobileNumber],
    );
  }

  Future<Map<String, dynamic>?> getUser({
    required String mobileNumber,
  }) async {
    List<Map<String, dynamic>> users = await _database.query(
      'users',
      where: 'mobileNumber = ?',
      whereArgs: [mobileNumber],
    );
    if (users.isNotEmpty) {
      return users.first;
    }
    return null;
  }

  Future<bool> doesUserExist(String mobileNumber) async {
  final Database db = _database;

  final List<Map<String, dynamic>> user = await db.query(
    'users',
    where: 'mobileNumber = ?',
    whereArgs: [mobileNumber],
    limit: 1,
  );

  return user.isNotEmpty;
}

  getTimestamp() => DateTime.now().millisecondsSinceEpoch;
}
