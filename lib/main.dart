import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';

import 'package:account_app/screen/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CustomerController customerController = Get.put(CustomerController());
  AccGroupController accGroupController = Get.put(AccGroupController());
  CurencyController curencyController = Get.put(CurencyController());
  CustomerAccountController customerAccountController =
      Get.put(CustomerAccountController());
  HomeController homeController = Get.put(HomeController());

  print(accGroupController.allAccGroups);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: MyColors.containerColor,
        ),
        // theme: AppThemes.darkTheme,
        home: MyMainScreen());
  }
}

class MyBoxess extends StatelessWidget {
  const MyBoxess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    //CustomDialog.customSnackBar('', '');
                  },
                  child: const Text("click here")),
            )
          ],
        ),
      ),
    );
  }
}

/*
 Center(
          child: DropdownButton<String>(
            borderRadius: BorderRadius.circular(10),
              value: "one",
              onChanged: (value) {
                print(value);
              },
              items: l
                  .map((e) => DropdownMenuItem(value: e, child: Text("Value")))
                  .toList())),

*/