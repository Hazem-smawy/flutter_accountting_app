import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/home/home.dart';
import 'package:account_app/widget/custom_button_widget.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                    // Get.defaultDialog(
                    //     title: "",
                    //     titleStyle: myTextStyles.title1,
                    //     middleTextStyle: myTextStyles.subTitle,
                    //     contentPadding: const EdgeInsets.all(10),
                    // middleText:
                    //     "تعني المحاسبة تتبع جميع المعاملات المالية المتعلقة بالعمل، والتي تتضمن تبويب المدخلات وتسجيلها وتلخيصها وتحليلها وإبلاغ ",
                    // content: Column(
                    //   children: [
                    //     FaIcon(
                    //       FontAwesomeIcons.circleCheck,
                    //       color: Colors.green.withOpacity(0.7),
                    //       size: 70,
                    //     ),
                    //     // SizedBox(height: 5),
                    //     // Text("  حذف",
                    //     //     style: myTextStyles.title1.copyWith(
                    //     //       fontWeight: FontWeight.normal,
                    //     //     )),
                    //     SizedBox(height: 10),
                    //     Text(
                    //       "تعني المحاسبة تتبع جميع المعاملات المالية   ",
                    //       textAlign: TextAlign.center,
                    //       style: myTextStyles.body,
                    //     ),
                    //   ],
                    // ),
                    // actions: [
                    //   Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //             elevation: 0,
                    //             minimumSize: Size(150, 50),
                    //             backgroundColor: Colors.transparent,
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(20),
                    //               side: BorderSide(
                    //                 color: Colors.red.withOpacity(0.7),
                    //                 width: 2,
                    //               ),
                    //             ),
                    //           ),
                    //           onPressed: () {},
                    //           child: Text(
                    //             "الغاء",
                    //             style: myTextStyles.title1.copyWith(
                    //               color: Colors.red,
                    //             ),
                    //           )),
                    //       const SizedBox(width: 5),
                    //       ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //             elevation: 0,
                    //             minimumSize: Size(150, 50),
                    //             backgroundColor:
                    //                 MyColors.primaryColor.withOpacity(0.9),
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(20),
                    //             ),
                    //           ),
                    //           onPressed: () {},
                    //           child: Text(
                    //             "موافق",
                    //             style: myTextStyles.title1
                    //                 .copyWith(color: Colors.white),
                    //           )),
                    //     ],
                    //   )
                    // ]);

                    // CustomDialog.showDialog(
                    //     title: 'اضافه الحساب',
                    //     description:
                    //         "تعني المحاسبة تتبع جميع المعاملات المالية",
                    //     icon: FontAwesomeIcons.circleCheck,
                    //     color: Colors.green);

                    // CustomDialog.showDialog(
                    //     title: ' حذف الحساب',
                    //     description:
                    //         "تعني المحاسبة تتبع جميع المعاملات المالية",
                    //     icon: FontAwesomeIcons.triangleExclamation,
                    //     color: Colors.red);

                    CustomDialog.customSnackBar('', '');

                    //CustomDialog.loadingProgress();
                  },
                  child: const Text("click here")),
            )
          ],
        ),
      ),
    );
  }
}
