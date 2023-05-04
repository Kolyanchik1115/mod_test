import 'package:flutter/material.dart';
import 'package:ShaderMod/pages/instruction/widgets/instruction_container.dart';
import 'package:ShaderMod/resources/app_colors.dart';
import 'package:ShaderMod/resources/app_images.dart';
import 'package:ShaderMod/resources/app_texts.dart';

class InstructionPage extends StatelessWidget {
  static const routeName = '/instruction';
  const InstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инструкция',style: AppText.txt3,),
        backgroundColor: AppColors.icon,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: ListView(
        children: List.generate(
          AppImages.images2.length,
          (index) => InstructionContainer(
              image: Image.asset(AppImages.images2[index])),
        ),
      ),
    );
  }
}
