import 'package:flutter_flurry_sdk/flurry.dart';

class FlurryAnalyticsService {
  FlurryAnalyticsService._();

  static void init() {
    Flurry.builder
        .withCrashReporting(true)
        .withLogEnabled(true)
        .withLogLevel(LogLevel.debug)
        .build(
          androidAPIKey: "Q7GFTZZMGY4TBNHRTVQ8",
        );
  }
}
