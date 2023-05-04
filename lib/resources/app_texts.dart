import 'package:flutter/material.dart';
import 'package:ShaderMod/resources/app_colors.dart';

class AppText {
  AppText._();
  static const TextStyle txt1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle txt2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static const TextStyle txt3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const TextStyle txt4 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
  static const TextStyle txt5 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.black,
  );
  static const TextStyle txt6 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    decoration: TextDecoration.underline,
  );
}
