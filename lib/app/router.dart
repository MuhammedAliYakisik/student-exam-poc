import 'package:go_router/go_router.dart';
import 'package:studen_exam_poc/feature/student/view/student_edit_view.dart';

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
      ]
  );
}