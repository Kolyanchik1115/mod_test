import 'package:flutter/material.dart';
import 'package:mod_test/pages/home/home_page.dart';
import 'package:mod_test/routes/app_routes.dart';

void main() {
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
      // home: const Scaffold(body: SplashScreen()),
      home: const HomePage(),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
