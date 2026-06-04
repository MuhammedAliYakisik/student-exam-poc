import 'package:flutter/cupertino.dart';
import 'package:studen_exam_poc/feature/course/course_service.dart';

import '../../core/getIt/locator.dart';
import 'course_model.dart';

class CourseViewModel extends ChangeNotifier {
  final CourseService _service = locator<CourseService>();

  List<CourseModel> courses = [];

  List<CourseModel> filteredCourses = [];

  bool isLoading = false;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchCourses() async {
    setLoading(true);

    try {
      final result = await _service.getCourses();
      courses = result;
      filteredCourses = result;
      notifyListeners();
      print("Dersler Çekme İşlemi Başarılı: ${courses.length}");
    }catch(e){
      print("Dersleri Çekme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> insertCourse(CourseModel course) async {
    setLoading(true);
    try{
      final newId = await _service.insertCourse(course);
      final savedCourse = CourseModel(
        id: newId,
        name: course.name);

      courses.add(savedCourse);
      filteredCourses.add(savedCourse);
      notifyListeners();
      print("Ders Ekleme İşlemi Başarılı: ${savedCourse.id}");
    }catch(e){
      print("Ders Ekleme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> deleteCourse(int id) async {
    setLoading(true);
    try {
      await _service.deleteCourse(id);
      courses.removeWhere((course) => course.id == id);
      filteredCourses.removeWhere((course) => course.id == id);
      notifyListeners();

    }catch(e){
      print("Ders Silme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> updateCourse(CourseModel course) async {
    setLoading(true);
    try {
      await _service.updateCourse(course);
      int courseIndex = courses.indexWhere((s) => s.id == course.id);
      if (courseIndex != -1) {
        courses[courseIndex] = course;
      }
      int filteredIndex = filteredCourses.indexWhere((s) => s.id == course.id);
      if (filteredIndex != -1) {
        filteredCourses[filteredIndex] = course;
      }
      notifyListeners();
      print("Ders Güncelleme İşlemi Başarılı: ${course.name}");
    }catch(e){
      print("Ders Güncelleme İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }

  Future<void> searchCourse(String query) async {
    setLoading(true);
    try {
      if (query.isEmpty) {
        filteredCourses = courses;
      } else {
        filteredCourses = await _service.searchCourse(query);
      }
      notifyListeners();
    }catch(e){
      print("Ders Arama İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }


}