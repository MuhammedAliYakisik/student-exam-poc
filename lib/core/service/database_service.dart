import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null){
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dataBasePath = await getDatabasesPath();
    final path = join(dataBasePath,'student_exam_poc.db');
    final exists = await databaseExists(path);

    if(exists == false){
      await _copyDatabase(path);
    }
    return await openDatabase(path);
  }


  Future<void> _copyDatabase(String path) async {
    await Directory(dirname(path)).create(recursive: true);

    final byteData = await rootBundle.load('assets/student_exam_poc.db');
    final bytes = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);
  }

  Future<void> closeDatabase() async {
    if(_database != null){
      await _database!.close();
    }
  }

}