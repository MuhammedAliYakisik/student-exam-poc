import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';
import 'package:studen_exam_poc/core/extension/size_extension.dart';
import 'package:studen_exam_poc/feature/student/student_model.dart';
import 'package:studen_exam_poc/feature/student/student_view_model.dart';

import '../../../components/appBar/custom_app_bar.dart';
import '../../../components/bottom_nav_bar/custom_bottom_nav_bar.dart';
import '../../../components/text/custom_text.dart';
import '../../../components/textfield/custom_textfield.dart';
import '../../../core/constant/color_constant.dart';

class StudentView extends StatefulWidget {
  const StudentView({super.key});

  @override
  State<StudentView> createState() => _StudentViewState();
}


class _StudentViewState extends State<StudentView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentViewModel>().fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarText: "Öğrenciler",
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 0,
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
      floatingActionButton: _buildFloatingActionButton(context),
      body: Consumer<StudentViewModel>(
        builder: (context,viewmodel,child){
          return Padding(
            padding:  EdgeInsets.all(context.lowValue),
            child: Column(
              children: [
                CustomTextField(
                  hintText: "Öğrenci Ara",
                  prefixIcon: Icons.search,
                  controller: searchController,
                  onChanged: (value) {

                    viewmodel.searchStudent(
                      value,
                    );

                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewmodel.filteredStudents.length,
                    itemBuilder: (context,index){
                      final student = viewmodel.filteredStudents[index];
                      return _studentCardContainer(context, student);
                    },
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}
Widget _studentCardContainer(BuildContext context, StudentModel? student) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(student?.fullName ?? "Öğrenciye Ait İsim Bulunmamaktadır.",
                      color: ColorConstant.instance.textPrimaryColor, fontWeight: FontWeight.bold, isTitle: true),
                  Gap(context.lowValue),
                  _buildIconText(context, Icons.mail_outline, student?.email ?? "Öğrenciye Ait Email Bulunmamaktadır."),
                  Gap(context.lowValue),
                  _buildIconText(context, Icons.call_outlined, student?.gsmNumber ?? "Öğrenciye Ait Telefon Numarası Bulunmamaktadır."),
                  Gap(context.lowValue),
                  _buildIconText(context, Icons.numbers_outlined, "Okul Numarası: ${student?.number ?? "Öğrenciye Ait Okul Numarası Bulunmamaktadır."}"),

                ],
              ),
            ),
          ],
        ),
        Gap(context.dynamicHeight(0.02)),
        const Divider(height: 2, thickness: 0.3),
        Gap(context.dynamicHeight(0.02)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                context.go('/StudentEdit/${student?.id}');
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
                _showPolicySheet(context, "Notlar",  "Bu öğrenciye ait not bulunmamaktadır.");
              },
              child: Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      context.lowValue),
                  color: ColorConstant.instance.infoColor
                      .withOpacity(
                      0.1)),
                  padding: EdgeInsets.all(context.lowValue),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline_rounded, size: context.dynamicHeight(0.03),
                        color: ColorConstant.instance.infoColor,),
                      CustomText("Detaylar", isSmall: true, fontWeight: FontWeight.bold,
                        color: ColorConstant.instance.infoColor,),
                    ],
                  )),
            ),
            GestureDetector(
              onTap: (){
                context.read<StudentViewModel>().deleteStudent(student?.id ?? 0);
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
FloatingActionButton _buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => context.go('/StudentAdd'),
    foregroundColor: Colors.white,
    backgroundColor: ColorConstant.instance.secondaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: const Icon(Icons.person_add_alt),
  );
}
void _showPolicySheet(BuildContext context, String title, String content) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(context.normalValue)),
    ),
    builder: (context) {
      return Container(
        height: context.dynamicHeight(0.5),
        padding: context.paddingNormal,
        child: Column(
          children: [
            Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
            ),
            Gap(context.lowHeightValue),
            CustomText(title, isTitle: true, fontWeight: FontWeight.bold),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: CustomText(content, isTitle: false, color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    },
  );
}
Widget _buildIconText(BuildContext context, IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: context.dynamicHeight(0.02), color: ColorConstant.instance.textSecondaryColor),
      Gap(context.dynamicHeight(0.01)),
      CustomText(text, isSmall: true),
    ],
  );
}
