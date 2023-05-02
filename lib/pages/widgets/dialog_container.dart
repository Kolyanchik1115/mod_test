import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mod_test/pages/widgets/shadow_container.dart';
import 'package:mod_test/resources/app_icons.dart';

class DialogContainer extends StatelessWidget {

  final Widget child;

  const DialogContainer({Key? key, required this.child})
      : super(key: key);

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
          colors: [
            Colors.white,
            Color.fromRGBO(224, 214, 255, 1)
          ],
        ),
        shadowColor: Color.fromRGBO(205, 155, 255, 1),
        child: Padding(
          padding: const EdgeInsets.all(15),
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
                padding: const EdgeInsets.all(42.0),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
