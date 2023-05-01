import 'package:flutter/material.dart';
import 'package:flutter_flurry_sdk/flurry.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mod_test/pages/install/install_page.dart';
import 'package:mod_test/pages/install/widgets/ad_button.dart';
import 'package:mod_test/pages/splash/splash_page.dart';
import 'package:mod_test/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  Flurry.builder
      .withCrashReporting(true)
      .withLogEnabled(true)
      .withLogLevel(LogLevel.debug)
      .withReportLocation(true)
      .build(androidAPIKey: 'Z4CV54XKQFVZ7RYTQ79C');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShaderMod',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const InstallPage(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
