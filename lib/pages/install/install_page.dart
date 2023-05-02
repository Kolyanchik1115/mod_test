import 'package:flutter/material.dart';
import 'package:flutter_flurry_sdk/flurry.dart';
import 'package:mod_test/pages/install/widgets/ad_dialog.dart';
import 'package:mod_test/pages/instruction/widgets/instruction_container.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/resources/app_colors.dart';
import 'package:mod_test/resources/app_consts.dart';
import 'package:mod_test/resources/app_images.dart';

class InstallPage extends StatelessWidget {
  static const routeName = '/install';

  const InstallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Shader Mod',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: AppColors.icon,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image.asset(AppImages.img0, fit: BoxFit.contain),
          ),
          const SizedBox(height: 20),
          buildInstallButtonWidget(context),
          const SizedBox(
            height: 25,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              AppConstantsString.text1,
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                'Особенности мода Eternal Shaders: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              AppConstantsString.text2,
              style: TextStyle(height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: List.generate(
                AppImages.installImages.length,
                (index) => InstructionContainer(
                  image: Image.asset(AppImages.installImages[index],fit: BoxFit.contain,),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: buildInstallButtonWidget(context),
          ),
        ],
      ),
    );
  }

  AppButtonWidget buildInstallButtonWidget(BuildContext context) {
    return AppButtonWidget(
      onPressed: () {
        Flurry.logEvent('Pressed INSTALL button');
        showDialog(
          context: context,
          builder: (_) => const AdDialog(),
        );
      },
      color: AppColors.icon,
      title: const Text(
        'Установить',
        style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
      ),
      height: 60,
      width: 250,
    );
  }
}
