import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/pages/widgets/dialog_container.dart';
import 'package:mod_test/resources/app_consts.dart';
import 'package:mod_test/resources/app_icons.dart';
import 'package:mod_test/resources/app_colors.dart';
import 'package:mod_test/resources/app_texts.dart';
import 'package:mod_test/services/review_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _currentRating = 0;
  String rateButtonText = 'ОЦЕНИТЬ';
  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Пожалуйста, оцените приложение.\nВаши отзывы очень\n важны для нас',
            style: AppText.txt5,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentRating = index + 1;
                      if (_currentRating >= 4) {
                        rateButtonText = 'RATE US ON GOOGLE PLAY';
                      } else {
                        rateButtonText = 'ОЦЕНИТЬ';
                      }
                    });
                  },
                  child: _currentRating > index
                      ? SvgPicture.asset(
                          AppIcons.starFill,
                          color: AppColors.icon,
                        )
                      : SvgPicture.asset(AppIcons.starClear),
                ),
              ),
            ),
          ),
          AppButtonWidget(
            color: AppColors.icon,
            title: Text(rateButtonText),
            height: 55,
            width: 230,
            onPressed: () async {
              Navigator.pop(context);
              if (_currentRating >= 4) {
                const url = AppConstantsString.linkToPlayMarket;
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              } else {
                showDialog(
                  context: context,
                  builder: (context) => const FeedbackAlert(),
                );
              }
              ReviewService.setRating(_currentRating);
            },
          ),
        ],
      ),
    );
  }
}

class FeedbackAlert extends StatelessWidget {
  const FeedbackAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DialogContainer(
      child: Text(
        'СПАСИБО ЗА ВАШ ОТЗЫВ',
        style: AppText.txt2,
      ),
    );
  }
}
