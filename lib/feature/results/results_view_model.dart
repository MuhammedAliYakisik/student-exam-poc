import 'package:flutter/cupertino.dart';
import 'package:studen_exam_poc/feature/results/results_model.dart';
import 'package:studen_exam_poc/feature/results/results_service.dart';

import '../../core/getIt/locator.dart';

class ResultsViewModel extends ChangeNotifier {
  final ResultsService _service = locator<ResultsService>();
  List<ResultsModel> results = [];
  bool isLoading = false;
  double averageScore = 0.0;
  int completedCourseCount = 0;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }


  Future<void> fetchResults() async {
    setLoading(true);

    try {
      results = await _service.getResults();
      notifyListeners();
      debugPrint(
        'Sonuçları Çekme İşlemi Başarılı: ${results.length}',
      );
    } catch (e) {
      debugPrint(
        'Sonuçları Çekme İşlemi Hata Verdi: $e',
      );
    }
    setLoading(false);
  }
  Future<void> fetchResultsByStudentId(int studentId,) async {
    setLoading(true);
    try {
      results = await _service.getResultsByStudentId(studentId,);
      notifyListeners();
      debugPrint(
        'Öğrenci Sonuçları Başarılı: ${results.length}',
      );
    } catch (e) {
      debugPrint(
        'Öğrenci Sonuçları Hata Verdi: $e',
      );
    }
    setLoading(false);
  }

  Future<void> addResults(ResultsModel result) async {
    try {
      await _service.insertResults(result);
      await fetchResults();
      debugPrint('Sonuç Ekleme Başarılı');
    }catch (e){
      debugPrint(
        'Sonuç Ekleme Hata Verdi: $e',
      );
    }
  }

  Future<void> updateResult(ResultsModel result,) async {
    try {
      await _service.updateResults(result);
      await fetchResults();
      debugPrint(
        'Sonuç Güncelleme Başarılı',
      );
    } catch (e) {
      debugPrint(
        'Sonuç Güncelleme Hata Verdi: $e',
      );
    }
  }

  Future<void> deleteResult(int id) async {
    try {
      await _service.deleteResults(id);
      await fetchResults();
      debugPrint('Sonuç Silme Başarılı');
    }catch(e) {
      debugPrint(
        'Sonuç Silme Hata Verdi: $e',
      );
    }
  }

  Future<void> fetchStudentAverageScore(int studentId,) async {
    try {
      averageScore = await _service.getStudentAverageScore(studentId,);
      notifyListeners();
    } catch (e) {
      debugPrint(
        'Ortalama Hesaplama Hata Verdi: $e',
      );
    }
  }

  Future<void> fetchCompletedCourseCount(int studentId) async {
    try {
      completedCourseCount = await _service.getCompletedCourseCount(studentId);
      notifyListeners();
    } catch (e) {
      debugPrint(
        'Tamamlanan Ders Hesabı Hata Verdi: $e',
      );
    }
  }
}
