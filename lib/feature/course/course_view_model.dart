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
      debugPrint("Dersler Çekme İşlemi Başarılı: ${courses.length}");
    }catch(e){
      debugPrint("Dersleri Çekme İşlemi Hata Verdi: $e");
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
      debugPrint("Ders Ekleme İşlemi Başarılı: ${savedCourse.id}");
    }catch(e){
      debugPrint("Ders Ekleme İşlemi Hata Verdi: $e");
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
      debugPrint("Ders Silme İşlemi Hata Verdi: $e");
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
      debugPrint("Ders Güncelleme İşlemi Başarılı: ${course.name}");
    }catch(e){
      debugPrint("Ders Güncelleme İşlemi Hata Verdi: $e");
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
      debugPrint("Ders Arama İşlemi Hata Verdi: $e");
    }
    setLoading(false);
  }


}