import 'package:event_planning/screens/chats_page.dart';
import 'package:event_planning/screens/event/create_event_page.dart';
import 'package:event_planning/screens/event/event_first_page.dart';
import 'package:event_planning/screens/event_owner/guest_list.dart';
import 'package:event_planning/screens/event_owner/home_page.dart';
import 'package:event_planning/screens/event_owner/my_reservations.dart';
import 'package:event_planning/screens/splash_screen.dart';
import 'package:event_planning/screens/event_owner/promo_code.dart';
import 'package:event_planning/screens/startup/login_page.dart';
import 'package:event_planning/screens/posts/post_details.dart';
import 'package:event_planning/screens/test.dart';
import 'package:event_planning/screens/vendor/profile/calender_view.dart';
import 'package:event_planning/screens/vendor/profile/vendor_profil_page.dart';
import 'package:event_planning/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'id',
  'name',
  'description',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Evento',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSwatch().copyWith(primary: pink)
                ),
            home:const  SplashScreen(),
          );
        });
  }
}
