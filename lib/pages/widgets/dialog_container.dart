import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mod_test/resources/app_icons.dart';

class DialogContainer extends StatelessWidget {
  final Widget? button;
  final Widget description;

  const DialogContainer({Key? key, this.button, required this.description}) : super(key: key);

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
              description,
              const SizedBox(height: 20),
              button ?? const SizedBox.shrink(),
              const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
