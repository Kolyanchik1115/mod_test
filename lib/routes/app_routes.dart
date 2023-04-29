import 'package:flutter/material.dart';
import 'package:mod_test/pages/home/home_page.dart';
import 'package:mod_test/pages/install/install_page.dart';
import 'package:mod_test/pages/instruction/instruction_page.dart';
import 'package:mod_test/pages/splash/splash_page.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;

    switch (settings.name) {
      case SplashPage.routeName:
        builder = (_) => const SplashPage();
        break;
      case HomePage.routeName:
        builder = (_) => const HomePage();
        break;
      case InstructionPage.routeName:
        builder = (_) => const InstructionPage();
        break;
      case InstallPage.routeName:
        builder = (_) => const InstallPage();
        break;
      default:
        throw Exception('Invalid route: ${settings.name}');
    }

    return MaterialPageRoute(
      builder: builder,
      settings: settings,
    );
  }
}
