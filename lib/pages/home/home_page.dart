import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mod_test/pages/home/widgets/icon_container.dart';
import 'package:mod_test/pages/install/install_page.dart';
import 'package:mod_test/pages/instruction/instruction_page.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/pages/widgets/rate_us.dart';
import 'package:mod_test/resources/app_consts.dart';
import 'package:mod_test/resources/app_icons.dart';
import 'package:mod_test/resources/app_images.dart';
import 'package:mod_test/resources/app_colors.dart';
import 'package:mod_test/resources/app_texts.dart';
import 'package:mod_test/services/review_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/homepage';

  void _checkLoginCountAndShowRatingDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        if (ReviewService.needToShowRateUs) {
          {
            showDialog(context: context, builder: (_) => const RatingDialog());
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ReviewService.onLogin();
    _checkLoginCountAndShowRatingDialog(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.icon,
        title:
            const Text('Shader mod', style: TextStyle(color: AppColors.white)),
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
              Expanded(
                child: IconContainer(
                  onPressed: () =>
                      Navigator.of(context).pushNamedAndRemoveUntil(
                    InstructionPage.routeName,
                    (route) => true,
                  ),
                  svg: SvgPicture.asset(AppIcons.instruction),
                  text: 'Инструкция',
                ),
              ),
              Expanded(
                child: IconContainer(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) => const RatingDialog(),
                    );
                  },
                  svg: SvgPicture.asset(AppIcons.rateUs),
                  text: 'Оцените нас',
                ),
              ),
              Expanded(
                child: IconContainer(
                  onPressed: () async {
                    await launchUrlString(
                      AppConstantsString.privacyPolicy,
                      mode: LaunchMode.inAppWebView,
                    );
                  },
                  svg: SvgPicture.asset(AppIcons.privacy),
                  text: 'Privacy\n policy',
                ),
              ),
            ],
          ),
          Expanded(
            child: AppButtonWidget(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  InstallPage.routeName,
                  (route) => true,
                );
              },
              color: AppColors.icon,
              title: const Text(
                'STRART',
                style: AppText.txt1,
              ),
              height: 53,
              width: 230,
              shadowColor: AppColors.icon,
            ),
          )
        ],
      ),
    );
  }
}
