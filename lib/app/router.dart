import 'package:go_router/go_router.dart';
import 'package:studen_exam_poc/feature/course/view/course_view.dart';
import 'package:studen_exam_poc/feature/student/view/student_edit_view.dart';

import '../feature/course/view/course_add_view.dart';
import '../feature/course/view/course_edit_view.dart';
import '../feature/student/view/student_add_view.dart';
import '../feature/student/view/student_view.dart';

class AppRouter {

  late final GoRouter router = GoRouter(
      initialLocation: '/Student',
      routes: [
        //Student
        GoRoute(
          path: '/Student',
          builder: (context, state) {
              return const StudentView();
          }
        ),
        GoRoute(
            path: '/StudentAdd',
            builder: (context, state) {
              return const StudentAddView();
            }
        ),
        GoRoute(
            path: '/StudentEdit/:id',
            builder: (context, state) {
              final studentIdStr = state.pathParameters['id'];
              final studentId = int.tryParse(studentIdStr ?? '') ?? 0;
              return StudentEditView(studentId: studentId);
            }
        ),
        //Course
        GoRoute(
            path: '/Course',
            builder: (context, state) {
              return const CourseView();
            }
        ),
        GoRoute(
            path: '/CourseAdd',
            builder: (context, state) {
              return const CourseAddView();
            }
        ),
        GoRoute(
            path: '/CourseEdit/:id',
            builder: (context, state) {
              final courseIdStr = state.pathParameters['id'];
              final courseId = int.tryParse(courseIdStr ?? '') ?? 0;
              return CourseEditView(courseId: courseId);
            }
        ),
   ]
  );
}