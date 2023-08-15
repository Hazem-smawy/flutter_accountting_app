import 'dart:ffi';

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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AccGroupCurencyController accGroupCurencyController =
      Get.put(AccGroupCurencyController());
  CustomerController customerController = Get.put(CustomerController());
  AccGroupController accGroupController = Get.put(AccGroupController());
  CurencyController curencyController = Get.put(CurencyController());
  JournalController journalController = Get.put(JournalController());
  CustomerAccountController customerAccountController =
      Get.put(CustomerAccountController());

  HomeController homeController = Get.put(HomeController());
  NewAccountController newAccountController = Get.put(NewAccountController());
  IntroController introController = Get.put(IntroController());
  PersonalController personalController = Get.put(PersonalController());
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
        home: Obx(() => introController.introShow.value
            ? ShowMyMainScreen()
            : MyEntroScreen()));
  }
}

class ShowMyMainScreen extends StatelessWidget {
  ShowMyMainScreen({super.key});
  AccGroupController accGroupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() => accGroupController.allAccGroups.isEmpty
        ? const Scaffold(
            backgroundColor: MyColors.bg, body: EmptyAccGroupsWidget())
        : MyMainScreen());
  }
}
