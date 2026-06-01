import 'package:flutter/material.dart';
import 'package:studen_exam_poc/app/router.dart';
import 'package:studen_exam_poc/app/theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    final theme = AppTheme().theme;
    return MaterialApp.router(
      routerConfig: appRouter.router,
      title: "Student Exam Poc",
      debugShowCheckedModeBanner: false,
      theme: theme,
    );
  }
}
