import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  ReviewService.toggle();
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  AppIcons.close,
                ),
              ),
            ),
            const Text(
              'Please rate the app.\n Your feedback is very\n important to us',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                  ),
                ),
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
                child: Text(
                  rateButtonText,
                ),
              ),
            ),
          ],
        ),
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
