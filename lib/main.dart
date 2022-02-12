import 'package:bookify/logics/cubit/signup_cubit.dart';
import 'package:bookify/constants/route.dart';
import 'package:bookify/presentation/screens/auth_screen/login/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rxdart/rxdart.dart';
import 'presentation/screens/auth_screen/login/auth_repository.dart';
import 'presentation/screens/splash_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

Map<String, dynamic>? localdata;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_bookify_notification');

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  // description
  importance: Importance.high,
);

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int? id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  _token = await messaging.getToken();
  print("firebasetoken :: ${_token}");

  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      selectedNotificationPayload = notificationAppLaunchDetails?.payload;
      // initialRoute = audio.routeName;
    }
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    // Update the iOS foreground notification presentation options to allow
    // heads up notifications.
    FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    )
        .then((value) {
      localSetup();
    });
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    initializeDateFormatting('es_ES').then((value) {
      runApp(MyApp());
    });
  });
}

void localSetup() async {
  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('notificationlogo');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
    selectedNotificationPayload = payload;
    selectNotificationSubject.add(payload!);
    if (localdata != null) {}
  });

  if (!kIsWeb) {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
      } else {}
    });

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
      } else {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      localdata = message.data;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin
            .show(
                notification.hashCode,
                notification.title,
                notification.body,
                NotificationDetails(
                  android: AndroidNotificationDetails(channel.id, channel.name,
                      channelDescription: channel.description,
                      icon: 'notificationlogo',
                      color: Colors.orange),
                ))
            .whenComplete(() {});
      } else {
        print("Received");
      }
    });
  }
}

String? _token;

Future<void> firebasetoken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  _token = await messaging.getToken();
  print("firebasetoken :: ${_token}");
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: MaterialApp(
        title: 'bookify',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (_routeSettings) => appRouteGaneragte(_routeSettings),
        theme: ThemeData(primarySwatch: Colors.orange, fontFamily: 'poppins'),
        // initialRoute: "/managerView",
        home: SplashScreen(),
      ),
    );
  }
}
