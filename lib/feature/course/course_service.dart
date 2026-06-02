import 'package:sqflite/sqflite.dart';
import 'package:studen_exam_poc/core/service/database_service.dart';
import 'package:studen_exam_poc/feature/course/course_model.dart';


class CourseService {
  final Future<Database> _databaseService = DatabaseService.instance.database;

  Future<int> insertCourse(CourseModel course) async {
    final db = await _databaseService;
    return await db.insert('course', course.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CourseModel>> getCourses() async {
    final db = await _databaseService;
    final List<Map<String, dynamic>> maps = await db.query('course');

    return maps.map((map) => CourseModel.fromMap(map)).toList();
  }

  Future<void> updateCourse(CourseModel course) async {
    final db = await _databaseService;
    await db.update('course', course.toMap(),where: 'id = ?',whereArgs: [course.id]);
  }

  Future<void> deleteCourse(int id) async {
    final db = await _databaseService;
    await db.delete('course',where: 'id = ?',whereArgs: [id]);
  }

  Future<List<CourseModel>> searchCourse(String word) async {
    final db = await _databaseService;
    final List<Map<String,dynamic>> maps = await db.query(
        'course',
        where: 'name LIKE ?',
        whereArgs: ['%$word%']);
    return maps.map((map) => CourseModel.fromMap(map)).toList();
  }

}