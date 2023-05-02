import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mod_test/pages/widgets/button_widget.dart';
import 'package:mod_test/pages/widgets/dialog_container.dart';
import 'package:mod_test/resources/app_consts.dart';
import 'package:mod_test/resources/app_icons.dart';
import 'package:mod_test/services/review_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _currentRating = 0;
  String rateButtonText = 'Rate';

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Please rate the app.\n Your feedback is very\n important to us',
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
                        rateButtonText = 'Rate on Google Play';
                      } else {
                        rateButtonText = 'Rate';
                      }
                    });
                  },
                  child: _currentRating > index
                      ? SvgPicture.asset(
                          AppIcons.starFill,
                          color: Colors.deepPurple,
                        )
                      : SvgPicture.asset(AppIcons.starClear),
                ),
              ),
            ),
          ),
          AppButtonWidget(
            color: Colors.deepPurple,
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    AppIcons.close,
                  ),
                ),
              ),
              const Text(
                'Thanks for your\n feedback',
                textAlign: TextAlign.center,
              ),
              const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
