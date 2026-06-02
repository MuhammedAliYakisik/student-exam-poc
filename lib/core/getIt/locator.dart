import 'package:get_it/get_it.dart';
import 'package:studen_exam_poc/feature/student/student_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {

  locator.registerLazySingleton<StudentService>(() => StudentService());


}