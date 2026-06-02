
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:studen_exam_poc/components/snackbar/custom_snack_bar.dart';
import 'package:studen_exam_poc/components/text/custom_text.dart';
import 'package:studen_exam_poc/core/extension/context_extension.dart';
import 'package:studen_exam_poc/core/extension/size_extension.dart';
import 'package:studen_exam_poc/feature/student/student_view_model.dart';

import '../../../components/appBar/custom_app_bar.dart';
import '../../../components/button/custom_button.dart';
import '../../../components/textfield/custom_textfield.dart';
import '../../../core/constant/color_constant.dart';
import '../student_model.dart';

class StudentEditView extends StatefulWidget {
  final int studentId;
  const StudentEditView({super.key,required this.studentId});

  @override
  State<StudentEditView> createState() => _StudentEditViewState();
}

class _StudentEditViewState extends State<StudentEditView> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController gsmNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<StudentViewModel>();
      final student = viewModel.students.firstWhere(
            (s) => s.id == widget.studentId,
        orElse: () => StudentModel(id: 0, fullName: '', number: '', email: '', gsmNumber: ''),
      );

      if(student.id != 0){
        fullNameController.text = student.fullName;
        numberController.text = student.number;
        emailController.text = student.email;
        gsmNumberController.text = student.gsmNumber;
      }
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    numberController.dispose();
    emailController.dispose();
    gsmNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarText: "Öğrenciyi Düzenle",
        leadingIcon: Icons.arrow_back_rounded,
        leadingOnPressed: () {
          context.go('/Student');
        },
      ),
      body: Consumer<StudentViewModel>(
        builder: (context, viewModel, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, Object? result) async {
              if (!didPop) {
                context.go('/Student');
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
                    Center(child: CustomText("Düzenleyiniz", isTitle: true,fontWeight: FontWeight.bold,)),
                    Gap(context.normalHeightValue),
                    CustomTextField(
                      controller: fullNameController,
                      label: "AD SOYAD",
                      hintText: "Örnek: Muhammed Ali Yakışık",
                      prefixIcon: Icons.account_circle_outlined,
                    ),
                    Gap(context.lowHeightValue),
                    CustomTextField(
                      controller: emailController,
                      label: "Email",
                      hintText: "Örnek: ali@gmail.com",
                      prefixIcon: Icons.mail_outline,
                    ),
                    Gap(context.lowHeightValue),
                    CustomTextField(
                      controller: numberController,
                      label: "NUMARA",
                      hintText: "Örnek: 123",
                      prefixIcon: Icons.numbers_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    Gap(context.lowHeightValue),
                    CustomTextField(
                      controller: gsmNumberController,
                      label: "TELEFON",
                      hintText: "Örnek: 05XX XXX XXXX",
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    Gap(context.highHeightValue),
                    CustomButton(
                      text: viewModel.isLoading
                          ? "Düzenleniyor..."
                          : "Öğrenciyi Düzenle",
                      textColor: Colors.white,
                      backgroundColor:
                      ColorConstant.instance.secondaryColor,
                      icon: Icons.edit_outlined,
                      height: context.dynamicHeight(0.07),
                      onPressed: viewModel.isLoading
                          ? null
                          : () => editStudent(),
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
  Future<void> editStudent() async {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final number = numberController.text.trim();
    final gsmNumber = gsmNumberController.text.trim();

    if (fullName.isEmpty || email.isEmpty || number.isEmpty || gsmNumber.isEmpty) {
      showCustomSnackBar(context, "Lütfen Tüm Alanları Doldurun", 1);
      return;
    }

    final updatedStudent = StudentModel(
      id: widget.studentId,
      fullName: fullName,
      email: email,
      number: number,
      gsmNumber: gsmNumber,
    );

    await context.read<StudentViewModel>().updateStudent(updatedStudent);
    showCustomSnackBar(context, "Öğrenci Düzenlendi", 2);
    context.go('/Student');
  }
}