import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studen_exam_poc/components/button/custom_button.dart';
import 'package:studen_exam_poc/components/snackbar/custom_snack_bar.dart';
import 'package:studen_exam_poc/components/textfield/custom_textfield.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';
import 'package:studen_exam_poc/feature/results/results_view_model.dart';
import 'package:studen_exam_poc/feature/student/student_view_model.dart';

import '../../../components/appBar/custom_app_bar.dart';
import '../../../components/bottom_nav_bar/custom_bottom_nav_bar.dart';
import '../../../components/dropdown/custom_dropdown.dart';
import '../../course/course_model.dart';
import '../../course/course_view_model.dart';
import '../../student/student_model.dart';
import '../results_model.dart';

class ResultsView extends StatefulWidget {
  const ResultsView({super.key});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  StudentModel? selectedStudent;
  CourseModel? selectedCourse;
  final exam1Controller = TextEditingController();
  final exam2Controller = TextEditingController();
  final exam3Controller = TextEditingController();
  List<ResultsModel> existingResults = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<StudentViewModel>().fetchStudents();
      await context.read<CourseViewModel>().fetchCourses();
    });
  }

  @override
  void dispose() {
    exam1Controller.dispose();
    exam2Controller.dispose();
    exam3Controller.dispose();
    super.dispose();
  }
  Future<void> loadExistingResults() async {
    if (selectedStudent == null || selectedCourse == null) {
      return;
    }

    final results = await context
        .read<ResultsViewModel>()
        .getResultsByStudentAndCourse(
      selectedStudent?.id ?? 0,
      selectedCourse?.id ?? 0,
    );

    existingResults = results;

    exam1Controller.clear();
    exam2Controller.clear();
    exam3Controller.clear();

    if (results.isNotEmpty) {
      if (results.length >= 1) {
        exam1Controller.text = results[0].score.toString();
      }

      if (results.length >= 2) {
        exam2Controller.text = results[1].score.toString();
      }

      if (results.length >= 3) {
        exam3Controller.text = results[2].score.toString();
      }
    }

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarText: "Sonuçlar",
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/Student');
              break;
            case 1:
              context.go('/Course');
              break;
            case 2:
              context.go('/Results');
              break;
          }
        },),
      body: Consumer3<StudentViewModel,CourseViewModel,ResultsViewModel>(
          builder: (context,studentVm,courseVm,resultsVm,child){
            final students = studentVm.students;
            final courses = courseVm.courses;
            return Padding(
              padding:  EdgeInsets.all(context.lowValue),
              child: Column(
                children: [
                  _buildDropdownSelector(students, courses),
                  Gap(context.normalHeightValue),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: exam1Controller,
                          label: "1.Sınav",
                          hintText: "Not",
                          prefixIcon: Icons.edit_note_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Gap(context.veryLowWidthValue),
                      Expanded(
                        child: CustomTextField(
                          controller: exam2Controller,
                          label: "2.Sınav",
                          hintText: "Not",
                          prefixIcon: Icons.edit_note_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Gap(context.veryLowWidthValue),
                      Expanded(
                        child: CustomTextField(
                          controller: exam3Controller,
                          label: "3.Sınav",
                          hintText: "Not",
                          prefixIcon: Icons.edit_note_outlined,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Gap(context.mediumHeightValue),
                  CustomButton(text: "Kaydet", onPressed: () async {
                    if (selectedStudent == null || selectedCourse == null) {
                      showCustomSnackBar(
                        context,
                        "Lütfen öğrenci ve ders seçiniz.",
                        1,
                      );
                      return;
                    }

                    final notes = [
                      exam1Controller.text.trim(),
                      exam2Controller.text.trim(),
                      exam3Controller.text.trim(),
                    ];

                    if (notes.every((e) => e.isEmpty)) {
                      showCustomSnackBar(
                        context,
                        "Lütfen en az bir sınav notu giriniz.",
                        1,
                      );
                      return;
                    }

                    for (int i = 0; i < notes.length; i++) {
                      if (notes[i].isEmpty) continue;

                      final score = double.tryParse(notes[i]);

                      if (score == null) {
                        showCustomSnackBar(context, "Geçerli bir not giriniz.", 1,);
                        return;
                      }

                      if (existingResults.length > i) {
                        await resultsVm.updateResult(
                          ResultsModel(
                            id: existingResults[i].id,
                            studentId: selectedStudent?.id ?? 0,
                            courseId: selectedCourse?.id ?? 0,
                            score: score,
                          ),
                        );
                      } else {
                        await resultsVm.addResults(
                          ResultsModel(
                            id: null,
                            studentId: selectedStudent?.id ?? 0,
                            courseId: selectedCourse?.id ?? 0,
                            score: score,
                          ),
                        );
                      }
                    }

                    await loadExistingResults();

                    showCustomSnackBar(
                      context, "Kaydetme işlemi başarılı", 2,);
                  })
                ],
              ),
            );
          }
      ),
    );
  }
  Widget _buildDropdownSelector(List<StudentModel> students, List<CourseModel> courses) {
      return Column(
        children: [
          CustomDropdown<StudentModel>(
            hintText: "Öğrenciyi Seçin",
            prefixIcon: Icons.person_search_outlined,
            value: selectedStudent,
            items: students.map((p) => DropdownMenuItem(value: p, child: Text(p.fullName, overflow: TextOverflow.ellipsis))).toList(),
              onChanged: (val) async {
                setState(() {
                  selectedStudent = val;
                });
                await loadExistingResults();
              }
          ),
          CustomDropdown<CourseModel>(
            hintText: "Dersi Seçin",
            prefixIcon: Icons.book_outlined,
            value: selectedCourse,
            items: courses.map((c) => DropdownMenuItem(value: c, child: Text(c.name, overflow: TextOverflow.ellipsis))).toList(),
              onChanged: (val) async {
                setState(() {
                  selectedCourse = val;
                });
                await loadExistingResults();
              }
          ),
        ],
      );
  }
}

