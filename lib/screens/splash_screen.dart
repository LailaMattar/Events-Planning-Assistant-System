import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/startup/login_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:event_planning/utils/utils_fun.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  initNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("test notification alert");
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // debugPrint('notification body : '+notification!.body.toString());
      // debugPrint('title : '+notification.title.toString());
      // debugPrint('notification image : '+notification.android!.imageUrl.toString());
      // debugPrint('notification json : '+notification.android.toString());
      // debugPrint('title : '+notification.android);
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: pink,
                playSound: true,
                icon: '@mipmap/launcher_icon',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title.toString()),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body.toString())],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  void initState() {
    debugPrint("test fcm2");
    initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: const Image(
        image: AssetImage("assets/logo/logo4.png"),
      ),
      showLoader: false,
      navigator: LoginPage(),
      durationInSeconds: 5,
      backgroundColor: pink,
      logoSize: 100.h,
    );
  }
}
