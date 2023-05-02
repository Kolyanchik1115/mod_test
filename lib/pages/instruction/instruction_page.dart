import 'package:flutter/material.dart';
import 'package:mod_test/pages/instruction/widgets/instruction_container.dart';
import 'package:mod_test/resources/app_colors.dart';
import 'package:mod_test/resources/app_images.dart';

class InstructionPage extends StatelessWidget {
  static const routeName = '/instruction';
  const InstructionPage({super.key});

  final List imagePaths = const [
    AppImages.i1,
    AppImages.i2,
    AppImages.i3,
    AppImages.i4,
    AppImages.i5,
    AppImages.i6,
    AppImages.i7,
    AppImages.i8,
    AppImages.i9,
    AppImages.i10,
    AppImages.i11,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инструкция'),
        backgroundColor: AppColors.icon,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ListView(
        children: List.generate(
          imagePaths.length,
          (index) =>
              InstructionContainer(image: Image.asset(imagePaths[index])),
        ),
      ),
    );
  }
}
