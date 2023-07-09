import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/home/home.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: MyColors.containerColor,
      ),
      home: HomeScreen(),
    );
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
                    CustomDialog.customSnackBar('', '');
                  },
                  child: const Text("click here")),
            )
          ],
        ),
      ),
    );
  }
}
