import 'package:flutter/material.dart';
import 'package:flutter_flurry_sdk/flurry.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mod_test/pages/splash/splash_page.dart';
import 'package:mod_test/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashPage(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
