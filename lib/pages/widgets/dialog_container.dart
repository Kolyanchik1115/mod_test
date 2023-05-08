import 'package:ShaderMod/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ShaderMod/pages/widgets/shadow_container.dart';
import 'package:ShaderMod/resources/app_icons.dart';

class DialogContainer extends StatelessWidget {
  final Widget child;

  const DialogContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ShadowContainer(
        borderRadius: 30,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.dialogGradientStart, AppColors.dialogGradientEnd],
        ),
        shadowColor: AppColors.dialogShadow,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
