import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';
import 'package:studen_exam_poc/core/extension/size_extension.dart';


import '../../../components/appBar/custom_app_bar.dart';
import '../../../components/bottom_nav_bar/custom_bottom_nav_bar.dart';
import '../../../components/text/custom_text.dart';
import '../../../components/textfield/custom_textfield.dart';
import '../../../core/constant/color_constant.dart';
import '../course_model.dart';
import '../course_view_model.dart';

class CourseView extends StatefulWidget {
  const CourseView({super.key});

  @override
  State<CourseView> createState() => _CourseViewState();
}


class _CourseViewState extends State<CourseView> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CourseViewModel>().fetchCourses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarText: "Dersler",
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1,
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
      body: Consumer<CourseViewModel>(
          builder: (context,viewmodel,child){
            return Padding(
              padding:  EdgeInsets.all(context.lowValue),
              child: Column(
                children: [
                  CustomTextField(
                    hintText: "Ders Ara",
                    prefixIcon: Icons.search,
                    controller: searchController,
                    onChanged: (value) {

                      viewmodel.searchCourse(
                        value,
                      );

                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: viewmodel.filteredCourses.length,
                      itemBuilder: (context,index){
                        final course = viewmodel.filteredCourses[index];
                        return _courseCardContainer(context, course);
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
Widget _courseCardContainer(BuildContext context, CourseModel? course) {
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
FloatingActionButton _buildFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => context.go('/CourseAdd'),
    foregroundColor: Colors.white,
    backgroundColor: ColorConstant.instance.secondaryColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: const Icon(Icons.add_outlined),
  );
}
