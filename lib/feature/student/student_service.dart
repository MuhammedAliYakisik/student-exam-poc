import 'package:sqflite/sqflite.dart';
import 'package:studen_exam_poc/core/service/database_service.dart';
import 'package:studen_exam_poc/feature/student/student_model.dart';

class StudentService {
  final Future<Database> _databaseService = DatabaseService.instance.database;

  Future<int> insertStudent(StudentModel student) async {
    final db = await _databaseService;
    return await db.insert('student', student.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<StudentModel>> getStudents() async {
    final db = await _databaseService;
    final List<Map<String, dynamic>> maps = await db.query('student');

    return maps.map((map) => StudentModel.fromMap(map)).toList();
  }

  Future<void> updateStudent(StudentModel student) async {
    final db = await _databaseService;
    await db.update('student', student.toMap(),where: 'id = ?',whereArgs: [student.id]);
  }

  Future<void> deleteStudent(int id) async {
    final db = await _databaseService;
    await db.delete('student',where: 'id = ?',whereArgs: [id]);
  }

  Future<List<StudentModel>> searchStudent(String word) async {
    final db = await _databaseService;
    final List<Map<String,dynamic>> maps = await db.query(
        'student',
        where: 'full_name LIKE ? OR number LIKE ? OR email LIKE ? OR gsm_number LIKE ?',
        whereArgs: ['%$word%','%$word%','%$word%','%$word%']);
    return maps.map((map) => StudentModel.fromMap(map)).toList();
  }

}