import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studen_exam_poc/components/snackbar/custom_snack_bar.dart';
import 'package:studen_exam_poc/components/text/custom_text.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';
import 'package:studen_exam_poc/core/extension/size_extension.dart';

import '../../../components/appBar/custom_app_bar.dart';
import '../../../components/button/custom_button.dart';
import '../../../components/textfield/custom_textfield.dart';
import '../../../core/constant/color_constant.dart';
import '../course_model.dart';
import '../course_view_model.dart';


class CourseAddView extends StatefulWidget {
  const CourseAddView({super.key});

  @override
  State<CourseAddView> createState() => _CourseAddViewState();
}

class _CourseAddViewState extends State<CourseAddView> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarText: "Ders Ekle",
        leadingIcon: Icons.arrow_back_rounded,
        leadingOnPressed: () {
          context.go('/Course');
        },
      ),
      body: Consumer<CourseViewModel>(
        builder: (context, viewModel, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, Object? result) async {
              if (!didPop) {
                context.go('/Course');
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.paddingLowHorizontal.horizontal,
                  vertical: context.paddingLowVertical.vertical,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(context.normalHeightValue),
                    Center(child: CustomText("Ders İsmini Giriniz", isTitle: true,fontWeight: FontWeight.bold,)),
                    Gap(context.normalHeightValue),
                    CustomTextField(
                      controller: nameController,
                      label: "Ders İsmi",
                      hintText: "Örnek: Felsefe",
                      prefixIcon: Icons.book_outlined,
                    ),
                    Gap(context.normalHeightValue),
                    CustomButton(
                      text: viewModel.isLoading
                          ? "Ekleniyor..."
                          : "Ders Ekle",
                      textColor: Colors.white,
                      backgroundColor:
                      ColorConstant.instance.secondaryColor,
                      icon: Icons.save_outlined,
                      height: context.dynamicHeight(0.07),
                      onPressed: viewModel.isLoading
                          ? null
                          : () => saveCourse(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> saveCourse() async {
    final name = nameController.text.trim();

    if (name.isEmpty ) {
      showCustomSnackBar(context, "Lütfen Ders İsmini Doldurun", 1);
      return;
    }

    final course = CourseModel(
      id: null,
      name: name,
    );

    await context.read<CourseViewModel>().insertCourse(course);
    showCustomSnackBar(context, "Ders Eklendi", 2);
    context.go('/Course');
  }
}