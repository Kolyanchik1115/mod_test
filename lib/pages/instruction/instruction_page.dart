import 'package:flutter/material.dart';
import 'package:mod_test/pages/instruction/widgets/instruction_container.dart';
import 'package:mod_test/resources/app_images.dart';

class InstructionPage extends StatelessWidget {
  static const routeName = '/instruction';

  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InstructionContainer(image: Image.asset(AppImages.i1)),
          InstructionContainer(image: Image.asset(AppImages.i2)),
          InstructionContainer(image: Image.asset(AppImages.i3)),
          InstructionContainer(image: Image.asset(AppImages.i4)),
          InstructionContainer(image: Image.asset(AppImages.i5)),
          InstructionContainer(image: Image.asset(AppImages.i6)),
          InstructionContainer(image: Image.asset(AppImages.i7)),
          InstructionContainer(image: Image.asset(AppImages.i8)),
          InstructionContainer(image: Image.asset(AppImages.i9)),
          InstructionContainer(image: Image.asset(AppImages.i10)),
          InstructionContainer(image: Image.asset(AppImages.i11)),
        ],
      ),
    );
  }
}
