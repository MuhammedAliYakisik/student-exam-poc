import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studen_exam_poc/components/button/custom_button.dart';
import 'package:studen_exam_poc/components/snackbar/custom_snack_bar.dart';
import 'package:studen_exam_poc/components/textfield/custom_textfield.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';
import 'package:studen_exam_poc/core/extension/size_extension.dart';
import 'package:studen_exam_poc/feature/results/results_view_model.dart';
import 'package:studen_exam_poc/feature/student/student_view_model.dart';

import '../../../components/appBar/custom_app_bar.dart';
import '../../../components/bottom_nav_bar/custom_bottom_nav_bar.dart';
import '../../../components/dropdown/custom_dropdown.dart';
import '../../../components/text/custom_text.dart';
import '../../../core/constant/color_constant.dart';
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
                    if(selectedStudent != null && selectedCourse != null) {
                      final String note1 = exam1Controller.text.trim();
                      final String note2 = exam2Controller.text.trim();
                      final String note3 = exam3Controller.text.trim();

                      if (note1.isEmpty && note2.isEmpty && note3.isEmpty) {
                        showCustomSnackBar(context, "Lütfen en az bir sınav notu giriniz.", 1);
                        return;
                      }
                      if (note1.isNotEmpty) {
                        await resultsVm.addResults(
                          ResultsModel(
                            id: 0,
                            studentId: selectedStudent?.id ?? 0,
                            courseId: selectedCourse?.id ?? 0,
                            score: double.tryParse(note1) ?? 0.0,
                          ),
                        );
                      }
                      if (note2.isNotEmpty) {
                        await resultsVm.addResults(
                          ResultsModel(
                            id: 0,
                            studentId: selectedStudent?.id ?? 0,
                            courseId: selectedCourse?.id ?? 0,
                            score: double.tryParse(note2) ?? 0.0,
                          ),
                        );
                      }
                      if (note3.isNotEmpty) {
                        await resultsVm.addResults(
                          ResultsModel(
                            id: 0,
                            studentId: selectedStudent?.id ?? 0,
                            courseId: selectedCourse?.id ?? 0,
                            score: double.tryParse(note3) ?? 0.0,
                          ),
                        );
                      }
                      showCustomSnackBar(context, "Kaydetme işlemi başarılı", 2);
                      exam1Controller.clear();
                      exam2Controller.clear();
                      exam3Controller.clear();
                    }else {
                      showCustomSnackBar(context, "Lütfen öğrenci ve ders seçiniz.", 1);
                    }
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
            onChanged: (val) => setState(() => selectedStudent = val),
          ),
          CustomDropdown<CourseModel>(
            hintText: "Dersi Seçin",
            prefixIcon: Icons.book_outlined,
            value: selectedCourse,
            items: courses.map((c) => DropdownMenuItem(value: c, child: Text(c.name, overflow: TextOverflow.ellipsis))).toList(),
            onChanged: (val) => setState(() => selectedCourse = val),
          ),
        ],
      );
  }
}

Widget _resultsCardContainer(BuildContext context, CourseModel? course) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: context.lowHeightValue),
    padding: context.paddingNormal,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(course?.name ?? "Derse Bulunmamaktadır.",
                        color: ColorConstant.instance.textPrimaryColor, fontWeight: FontWeight.bold, isTitle: true),
                    Gap(context.lowValue),

                  ],
                ),
              ),
            ),
          ],
        ),
        Gap(context.dynamicHeight(0.01)),
        const Divider(height: 2, thickness: 0.3),
        Gap(context.dynamicHeight(0.015)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                context.go('/CourseEdit/${course?.id}');
              },
              child: Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      context.lowValue),
                  color: ColorConstant.instance.secondaryColor
                      .withOpacity(
                      0.1)),
                  padding: EdgeInsets.all(context.lowValue),
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined, size: context.dynamicHeight(0.03),
                        color: ColorConstant.instance.secondaryColor,),
                      CustomText("Düzenle", isSmall: true, fontWeight: FontWeight.bold,
                        color: ColorConstant.instance.secondaryColor,),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: (){
                context.read<CourseViewModel>().deleteCourse(course?.id ?? 0);
              },
              child: Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      context.lowValue),
                  color: ColorConstant.instance.errorColor
                      .withOpacity(
                      0.1)),
                  padding: EdgeInsets.all(context.lowValue),
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline_outlined, size: context.dynamicHeight(0.03),
                        color: ColorConstant.instance.errorColor,),
                      CustomText("Sil", isSmall: true, fontWeight: FontWeight.bold,
                        color: ColorConstant.instance.errorColor,),
                    ],
                  )),
            ),
          ],
        ),
      ],
    ),
  );
}

