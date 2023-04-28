import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mod_test/pages/home/widgets/icon_container.dart';
import 'package:mod_test/pages/instruction/instruction_page.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/resources/app_icons.dart';
import 'package:mod_test/resources/app_images.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text('Shader mod', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(AppImages.allWorlds),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconContainer(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  InstructionPage.routeName,
                  (route) => true,
                ),
                svg: SvgPicture.asset(AppIcons.instruction),
                text: 'Instruction',
              ),
              IconContainer(
                onPressed: () {},
                svg: SvgPicture.asset(AppIcons.instruction),
                text: 'Rate us',
              ),
              IconContainer(
                onPressed: () {},
                svg: SvgPicture.asset(AppIcons.instruction),
                text: 'Privacy\n policy',
              ),
            ],
          ),
          const Expanded(
            child: AppButtonWidget(
              color: Colors.deepPurpleAccent,
              title: Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              height: 53,
              width: 230,
              shadowColor: Colors.deepPurple,
            ),
          )
        ],
      ),
    );
  }
}
