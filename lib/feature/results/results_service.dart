import 'package:sqflite/sqflite.dart';
import 'package:studen_exam_poc/feature/results/results_model.dart';

import '../../core/service/database_service.dart';

class ResultsService {
  final Future<Database> _databaseService = DatabaseService.instance.database;

  Future<int> insertResults(ResultsModel results) async {
    final db = await _databaseService;
    return await db.insert('exam_result', results.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<ResultsModel>> getResults() async {
    final db = await _databaseService;
    final List<Map<String, dynamic>> maps = await db.query('exam_result');

    return maps.map((map) => ResultsModel.fromMap(map)).toList();
  }

  Future<void> updateResults(ResultsModel results) async {
    final db = await _databaseService;
    await db.update('exam_result', results.toMap(),where: 'id = ?',whereArgs: [results.id]);
  }

  Future<void> deleteResults(int id) async {
    final db = await _databaseService;
    await db.delete('exam_result',where: 'id = ?',whereArgs: [id]);
  }

  Future<List<ResultsModel>> getResultsByStudentId(int studentId) async {
    final db = await _databaseService;
    final List<Map<String, dynamic>> maps = await db.query(
      'exam_result',
      where: 'student_id = ?',
      whereArgs: [studentId],
    );

    return maps.map((map) => ResultsModel.fromMap(map)).toList();
  }

  Future<double> getStudentAverageScore(int studentId) async {
    final db = await _databaseService;
    final result = await db.rawQuery(
      '''
      SELECT AVG(score) as average_score 
      FROM exam_result 
      WHERE student_id = ? AND course_id IN (
          SELECT course_id 
          FROM exam_result 
          WHERE student_id = ? 
          GROUP BY course_id 
          HAVING COUNT(*) >= 3
      )
      ''',
      [studentId,studentId],
    );
    final average = result.first['average_score'];

    if (average == null) {
      return 0.0;
    }

    return (average as num).toDouble();

  }

  Future<int> getCompletedCourseCount(int studentId) async {
    final db = await _databaseService;

    final result = await db.rawQuery(
      '''
    SELECT course_id
    FROM exam_result
    WHERE student_id = ?
    GROUP BY course_id
    HAVING COUNT(*) >= 3
    ''',
      [studentId],
    );

    return result.length;
  }

}