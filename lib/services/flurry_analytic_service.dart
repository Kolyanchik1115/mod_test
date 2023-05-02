import 'package:flutter_flurry_sdk/flurry.dart';

class FlurryAnalyticsService {
  static void init() {
    Flurry.builder
        .withCrashReporting(true)
        .withLogEnabled(true)
        .withLogLevel(LogLevel.debug)
        .build(
        androidAPIKey: "Q7GFTZZMGY4TBNHRTVQ8",
        // iosAPIKey: FLURRY_IOS_API_KEY
        );
  }

//   /// Set, get, log Flurry events in anywhere of your codes.
//   static void example() async {
//     // Example to get Flurry versions.
//     int agentVersion = await Flurry.getAgentVersion();
//     print('Agent Version: $agentVersion');
//
//     String? releaseVersion = await Flurry.getReleaseVersion();
//     print('Release Version: $releaseVersion');
//
//     String? sessionId = await Flurry.getSessionId();
//     print('Session Id: $sessionId');
//
//     // Set Flurry preferences.
//     Flurry.setLogEnabled(true);
//     Flurry.setLogLevel(LogLevel.verbose);
//
//     // Set user preferences.
//     Flurry.setAge(36);
//     Flurry.setGender(Gender.female);
//     Flurry.setReportLocation(true);
//
//     // Set user properties.
//     var list = <String>[];
//     for (int i = 0; i < 6; i++) {
//       list.add('prop$i');
//     }
//     Flurry.userProperties.setValue(UserProperties.propertyRegisteredUser, 'True');
//     Flurry.userProperties.addValues('Flutter Properties', list);
//
//     // Log Flurry events.
//     Flurry.logEvent('Flutter Event');
//     var map = <String, String>{};
//     for (int i = 0; i < 6; i++) {
//       map.putIfAbsent('key$i', () => '$i');
//     }
//     Flurry.logTimedEventWithParameters('Flutter Timed Event', map, true);
//     Flurry.endTimedEvent('Flutter Timed Event');
//
//     // Log Flurry standard events.
//     var paramBuilder = Param()
//         .putDoubleParam(EventParam.totalAmount, 34.99)
//         .putBooleanParam(EventParam.success, true)
//         .putStringParam(EventParam.itemName, 'book 1')
//         .putString('note', 'This is an awesome book to purchase !!!');
//     Flurry.logStandardEvent(FlurryEvent.purchased, paramBuilder);
//   }
//
//   /// Example to get Flurry Remote Configurations.
//   static void config() {
//     Flurry.config.registerListener(MyConfigListener());
//     Flurry.config.fetchConfig();
//   }
//
//   /// Example to get Flurry Publisher Segmentation.
//   static void publisherSegmentation() {
//     Flurry.publisherSegmentation.registerListener(MyPublisherSegmentationListener());
//     Flurry.publisherSegmentation.fetch();
//   }
}
//
// /// Listener for Flurry Remote Configurations
// class MyConfigListener with ConfigListener {
//   @override
//   void onFetchSuccess() {
//     // Data fetched, activate it.
//     Flurry.config.activateConfig();
//   }
//
//   @override
//   void onFetchNoChange() {
//     // Fetch finished, but data unchanged.
//     Flurry.config.getConfigString('welcome_message', 'Welcome').then((welcomeMessage) {
//       print('Received unchanged data: $welcomeMessage');
//     });
//   }
//
//   @override
//   void onFetchError(bool isRetrying) {
//     // Fetch failed.
//     print('Fetch error! Retrying: $isRetrying');
//   }
//
//   @override
//   void onActivateComplete(bool isCache) {
//     // Received cached data, or newly activated data.
//     Flurry.config.getConfigString('welcome_message', 'Welcome').then((welcomeMessage) {
//       print((isCache ? 'Received cached data: $welcomeMessage' : 'Received newly activated data: $welcomeMessage'));
//     });
//   }
// }
//
// /// To enable Flurry Push for Android, please duplicate Builder setup in your FlutterApplication.java.
// /// ```dart
// ///   Flurry.builder
// ///       .withMessaging(true)
// ///       ...
// /// ```
// /// Optionally add a listener to receive messaging events, and handle the notification.
// /// ```dart
// ///   Flurry.builder
// ///       .withMessaging(true, MyMessagingListener())
// ///       ...
// /// ```
// class MyMessagingListener with MessagingListener {
//   @override
//   bool onNotificationClicked(Message message) {
//     printMessage('onNotificationClicked', message);
//     return false;
//   }
//
//   @override
//   bool onNotificationReceived(Message message) {
//     printMessage('onNotificationReceived', message);
//     return false;
//   }
//
//   @override
//   void onNotificationCancelled(Message message) {
//     printMessage('onNotificationCancelled', message);
//   }
//
//   @override
//   void onTokenRefresh(String token){
//     print('Flurry Messaging Type: onTokenRefresh'
//         '\n    Token: $token');
//   }
//
//   static printMessage(String type, Message message) {
//     print('Flurry Messaging Type: $type'
//         '\n    Title: $message.title'
//         '\n    Body: $message.body'
//         '\n    ClickAction: $message.clickAction'
//         '\n    Data: $message.appData');
//   }
// }
//
// /// Listener for Flurry Publisher Segmentation
// class MyPublisherSegmentationListener with PublisherSegmentationListener {
//   @override
//   void onFetched(Map<String, String> data) {
//     print('Publisher Segmentation data fetched: $data');
//   }
// }