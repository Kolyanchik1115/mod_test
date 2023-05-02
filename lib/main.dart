import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mod_test/pages/splash/splash_page.dart';
import 'package:mod_test/routes/app_routes.dart';
import 'package:mod_test/services/flurry_analytic_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  FlurryAnalyticsService.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'ShaderMod',
      home: SplashPage(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
