import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mod_test/pages/home/widgets/icon_container.dart';
import 'package:mod_test/pages/install/install_page.dart';
import 'package:mod_test/pages/instruction/instruction_page.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/pages/widgets/rate_us.dart';
import 'package:mod_test/resources/app_icons.dart';
import 'package:mod_test/resources/app_images.dart';
import 'package:mod_test/services/review_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/homepage';

  HomePage({super.key}) {
    _setup();
  }

  void _setup() async {
    await ReviewService.onLogin();
  }

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
    _checkLoginCountAndShowRatingDialog(context);
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
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (_) => const RatingDialog(),
                  );
                },
                svg: SvgPicture.asset(AppIcons.rateUs),
                text: 'Rate us',
              ),
              IconContainer(
                onPressed: () async {
                  const url = 'https://www.iubenda.com/privacy-policy/48055999';
                  await launchUrlString(
                    url,
                    mode: LaunchMode.inAppWebView,
                  );
                },
                svg: SvgPicture.asset(AppIcons.privacy),
                text: 'Privacy\n policy',
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
              color: Colors.deepPurple,
              title: const Text(
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
