import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:model_repository/model_repository.dart';
import 'package:o18_client/firebase_options.dart';
import 'package:o18_client/screen_router.dart';
import 'package:o18_client/simple_bloc_observer.dart';
import 'package:o18_client/theme/style/app_theme.dart';
import 'package:o18_client/utils/utils.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:storage_repository/storage_repository.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();
  showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  log('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(
  RemoteMessage message,
) {
  final notification = message.notification;
  final android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // TODO add a proper drawable resource to android, for now using
          //      one that already exists in example app.
          // icon: 'launch_background',
        ),
      ),
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Initialize the Firebase messaging
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  /// Request permission
  await FirebaseMessaging.instance.requestPermission();

  /// Listen to messages
  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  /// Listen to background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Create a [AndroidNotificationChannel] for heads up notifications
  await setupFlutterNotifications();

  // TODO
  // final token = await FirebaseMessaging.instance.getToken();
  // if (token != null) {
  //   await StorageRepository.setString('token', token);
  // }

  await dotenv.load();
  await StorageRepository.getInstance();

  await Parse().initialize(
    dotenv.env[Keys.parseAppId]!,
    dotenv.env[Keys.parseServerUrl]!,
    clientKey: dotenv.env[Keys.clientKey]!,
    coreStore: await CoreStoreSembast.getInstance(),
    registeredSubClassMap: <String, ParseObjectConstructor>{
      'UserRequest': UserRequest.new,
      'House': House.new,
      'Flat': Flat.new,
      'Owner': Owner.new,
      'Account': Account.new,
      'RequestNumber': RequestNumber.new,
      'Partner': Partner.new,
      'Staff': Staff.new,
      'CouncilMember': CouncilMember.new,
      'HouseMessage': HouseMessage.new,
      'Counter': Counter.new,
      'Image': ImageFile.new,
    },
  );

  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  ScreenRouter screenRouter = ScreenRouter();

  @override
  Widget build(
    BuildContext context,
  ) =>
      MaterialApp(
        theme: AppTheme.light,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: screenRouter.generateRoute,
        onUnknownRoute: screenRouter.unknownRoute,
        initialRoute: '/',
      );
}
