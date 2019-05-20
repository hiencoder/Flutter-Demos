import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/model/note.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  //Column name
  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes';
    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, '
        '$colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  //Fetch all note
  Future<List<Map<String, dynamic>>> getAllNote() async {
    Database database = await this.database;
    //Rawquery
    var result =
        database.rawQuery('SELECT * FROM $noteTable ORDER BY $colPriority ASC');
    return result;
    //query
    //var result = database.query(noteTable,orderBy: '$colPriority ASC',);
  }

  //Insert note
  Future<int> insertNote(Note note) async {
    Database database = await this.database;
    var result = await database.insert(noteTable, note.toMap());
    return result;
  }

  //Update note
  Future<int> updateNote(Note note) async {
    Database database = await this.database;
    var result = await database.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  //Delete note
  Future<int> deleteNote(Note note) async {
    Database database = await this.database;
    var result = await database
        .delete(noteTable, where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  //Delete note using sql query
  Future<int> deleteNoteById(int id) async {
    Database database = await this.database;
    var result =
        await database.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  //Get number note
  Future<int> getCount() async {
    Database database = await this.database;
    List<Map<String, dynamic>> x =
        await database.rawQuery("SELECT COUNT (*) FROM $noteTable");
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //Get list map -> convert to list note
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getAllNote(); //Get map list from database
    int count = noteMapList.length; //get number note

    List<Note> notes = List<Note>();
    for (int i = 0; i < count; i++) {
      notes.add(Note.fromMapObject(noteMapList[i]));
    }

    return notes;
  }
}
