import 'package:flutter/material.dart';
import 'package:mod_test/pages/install/widgets/ad_button.dart';
import 'package:mod_test/pages/widgets/dialog_container.dart';
import 'package:mod_test/resources/app_texts.dart';

class AdDialog extends StatelessWidget {
  const AdDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      child: Column(
        children: const [
          Text(
            'Чтобы установить мод в \nМайнкрафт, вам нужно \nпосмотреть рекламу',
            textAlign: TextAlign.center,
            style: AppText.txt5,
          ),
          SizedBox(height: 36),
          RewardedAdButton(),
        ],
      ),
    );
  }
}
