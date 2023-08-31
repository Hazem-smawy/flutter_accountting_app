import 'dart:async';
import 'dart:io' as io;
import 'dart:ui';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/copy_controller.dart';

import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/main_controller.dart';
import 'package:account_app/controller/sitting_controller.dart';
import 'package:account_app/models/sitting_model.dart';
import 'package:account_app/screen/intro_screen/intro_screen.dart';
import 'package:account_app/screen/main_screen/main_screen.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/sitting_data.dart';
import 'package:account_app/service/http_service/google_drive_service.dart';
import 'package:account_app/widget/custom_dialog.dart';

import 'package:account_app/widget/empty_accGroup_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalPlugin =
    FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel =
    AndroidNotificationChannel("coding is the life", "android channal service",
        description: "this is channel des..", importance: Importance.low);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(MainController());
  await initService();

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
      home: FutureBuilder(
        future: introController.readIntro(),
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              ConnectionState.done == snapshot.connectionState) {
            return introController.introShow.value
                ? ShowMyMainScreen()
                : const MyEntroScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
        },
      ),
    );
  }
}

Future<void> initService() async {
  var service = FlutterBackgroundService();
  if (io.Platform.isIOS) {
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
          notificationChannelId: "coding is the life",
          initialNotificationTitle: "coding is life servic",
          initialNotificationContent: "coding is life content",
          foregroundServiceNotificationId: 90));

  service.startService();
}

// onstart
@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
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

  SittingData sittingData = SittingData();
  SittingModel? sittingModel = await sittingData.read(1);
  final settingArray = [1, 2, 7, 30];

  print("$sittingModel");
  String title = "";
  if (sittingModel?.isCopyOn ?? false) {
    Timer.periodic(Duration(hours: 24 * settingArray[sittingModel?.every ?? 0]),
        (timer) async {
      flutterLocalPlugin.show(
        90,
        title,
        "تم عمل نسخة إحتياطية",
        const NotificationDetails(
          android: AndroidNotificationDetails(
              "coding is the life", "android channal service",
              ongoing: true, icon: "@mipmap/ic_launcher"),
        ),
      );
      GoogleDriveAppData googleDriveAppData = GoogleDriveAppData();
      GoogleSignInAccount? googleUser;
      DriveApi? driveApi;
      if (driveApi == null) {
        if (googleUser == null) {
          googleUser = await googleDriveAppData.signInGoogle();

          if (googleUser != null) {
            driveApi = await googleDriveAppData.getDriveApi(googleUser);
          } else {
            CustomDialog.customSnackBar(
                "حدث خطأ أثناء تسجيل الدخول", SnackPosition.TOP);
            return;
          }
        } else {
          driveApi = await googleDriveAppData.getDriveApi(googleUser);
        }
      }
      if (driveApi != null) {
        String path = await DatabaseService().fullPath;

        await googleDriveAppData.uploadDriveFile(
          driveApi: driveApi,
          file: io.File(path),
        );
        title = "تم عمل نسخة إحتياطية";
      } else {
        title = "حدث خطأ أثناء تسجيل الدخول";
      }

//notification
    });
  }
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
