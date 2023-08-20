import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/screen/intro_screen/intro_screen.dart';
import 'package:account_app/screen/main_screen/main_screen.dart';
import 'package:account_app/widget/empty_accGroup_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AccGroupCurencyController());
  Get.put(CustomerController());
  Get.put(AccGroupController());
  Get.put(CurencyController());
  Get.put(JournalController());
  Get.put(CustomerAccountController());
  Get.put(HomeController());
  Get.put(NewAccountController());
  Get.put(IntroController());
  Get.put(PersonalController());
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
      home: Obx(
        () => introController.introShow.value
            ? ShowMyMainScreen()
            : const MyEntroScreen(),
      ),
    );
  }
}

class ShowMyMainScreen extends StatelessWidget {
  ShowMyMainScreen({super.key});
  AccGroupController accGroupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => accGroupController.allAccGroups.isEmpty
          ? const Scaffold(
              backgroundColor: MyColors.bg,
              body: EmptyAccGroupsWidget(),
            )
          : MyMainScreen(),
    );
  }
}
