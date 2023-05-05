import 'package:ShaderMod/resources/app_colors.dart';
import 'package:ShaderMod/resources/app_texts.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  SnackBarService._();

  static Future<void> showSnackBar(
      {required BuildContext context,
      required String message,
      bool? error}) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Center(child: Text(message, style: AppText.txt1)),
      backgroundColor: error == true ? AppColors.error : AppColors.icon,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
