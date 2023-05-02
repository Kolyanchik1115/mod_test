import 'package:flutter/material.dart';
import 'package:mod_test/pages/install/widgets/ad_button.dart';
import 'package:mod_test/pages/widgets/dialog_container.dart';

class AdDialog extends StatelessWidget {
  const AdDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      child:
          Column(

            children: const [
              Text('To install a mod in\nMinecraft, you need\nto watch a video ad'),
              SizedBox(height: 36),
              RewardedAdButton(),
            ],
          ),

    );
  }
}
