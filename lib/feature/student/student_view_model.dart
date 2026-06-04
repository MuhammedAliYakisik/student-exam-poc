import 'package:flutter/cupertino.dart';
import 'package:studen_exam_poc/feature/student/student_model.dart';
import 'package:studen_exam_poc/feature/student/student_service.dart';

import '../../core/getIt/locator.dart';

class StudentViewModel extends ChangeNotifier {
  final StudentService _service = locator<StudentService>();

  List<StudentModel> students = [];

  List<StudentModel> filteredStudents = [];

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchStudents() async {
    setLoading(true);

    try {
      final result = await _service.getStudents();
      students = result;
      filteredStudents = result;
      notifyListeners();
      debugPrint("Öğrencileri Çekme İşlemi Başarılı: ${students.length}");
    }catch(e){
      debugPrint("Öğrencileri Çekme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> insertStudent(StudentModel student) async {
    setLoading(true);
    try{
      final newId = await _service.insertStudent(student);
      final savedStudent = StudentModel(
        id: newId,
        fullName: student.fullName,
        email: student.email,
        number: student.number,
        gsmNumber: student.gsmNumber,);

      students.add(savedStudent);
      filteredStudents.add(savedStudent);
      notifyListeners();
      debugPrint("Öğrenci Ekleme İşlemi Başarılı: ${savedStudent.id}");
    }catch(e){
      debugPrint("Öğrenci Ekleme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> deleteStudent(int id) async {
    setLoading(true);
    try {
      await _service.deleteStudent(id);
        students.removeWhere((student) => student.id == id);
        filteredStudents.removeWhere((student) => student.id == id);
        notifyListeners();

    }catch(e){
      debugPrint("Öğrenci Silme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> updateStudent(StudentModel student) async {
    setLoading(true);
    try {
      await _service.updateStudent(student);
      int studentIndex = students.indexWhere((s) => s.id == student.id);
      if (studentIndex != -1) {
        students[studentIndex] = student;
      }
      int filteredIndex = filteredStudents.indexWhere((s) => s.id == student.id);
      if (filteredIndex != -1) {
        filteredStudents[filteredIndex] = student;
      }
      notifyListeners();
      debugPrint("Öğrenci Güncelleme İşlemi Başarılı: ${student.fullName}");
    }catch(e){
      debugPrint("Öğrenci Güncelleme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> searchStudent(String query) async {
    setLoading(true);
    try {
      if (query.isEmpty) {
        filteredStudents = students;
      } else {
        filteredStudents = await _service.searchStudent(query);
      }
      notifyListeners();
    }catch(e){
      debugPrint("Öğrenci Arama İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }
}