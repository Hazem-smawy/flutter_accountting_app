import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/copy_controller.dart';

import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/main_controller.dart';
import 'package:account_app/screen/intro_screen/intro_screen.dart';
import 'package:account_app/screen/main_screen/main_screen.dart';
import 'package:account_app/widget/custom_dialog.dart';

import 'package:account_app/widget/empty_accGroup_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    CopyController copyController = Get.find();
    await copyController.uploadCopy();

    return Future.value(true);
  });
}

final FlutterLocalNotificationsPlugin flutterLocalPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel("coding is life", "android channal service",
        description: "this is channel des..", importance: Importance.high);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initService();
  Get.put(MainController());

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  IntroController introController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: MyColors.containerColor,
      ),
      // theme: AppThemes.darkTheme,
      //  home: ShowProgress(),
      home: Obx(
        () => introController.introShow.value
            ? ShowMyMainScreen()
            : const MyEntroScreen(),
      ),
    );
  }
}

Future<void> initService() async {
  var service = FlutterBackgroundService();
  if (Platform.isIOS) {
    await flutterLocalPlugin.initialize(
        const InitializationSettings(iOS: DarwinInitializationSettings()));
  }

  await flutterLocalPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(notificationChannel);

  await service.configure(
      iosConfiguration:
          IosConfiguration(onBackground: iosBackground, onForeground: onStart),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: true,
          isForegroundMode: true,
          notificationChannelId: "coding is life",
          initialNotificationTitle: "coding is life servic",
          initialNotificationContent: "coding is life content",
          foregroundServiceNotificationId: 90));

  service.startService();
}

// onstart
@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();

  service.on("setAsForeground").listen((event) {
    print("forground =====");
  });

  service.on("setAsBackground").listen((event) {
    print("bacground =====");
  });

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  //display notification

  // Timer.periodic(Duration(seconds: 2), (timer) {
  //   flutterLocalPlugin.show(
  //     90,
  //     "cool service",
  //     'this is the body',
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //           "coding is the life", "coding is life servic",
  //           ongoing: true, icon: "app_icon"),
  //     ),
  //   );
  // });
}

//ios
// onstart
@pragma('vm:entry-point')
Future<bool> iosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}

class ShowMyMainScreen extends StatelessWidget {
  ShowMyMainScreen({super.key});
  AccGroupController accGroupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => accGroupController.allAccGroups.isEmpty
          ? Scaffold(
              backgroundColor: MyColors.bg,
              body: EmptyAccGroupsWidget(),
            )
          : MyMainScreen(),
    );
  }
}
