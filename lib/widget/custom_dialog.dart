import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void customSnackBar(description, SnackPosition? snackPosition) {
    Get.rawSnackbar(
      backgroundColor: MyColors.lessBlackColor.withOpacity(0.9),
      //duration: const Duration(seconds: 10),
      snackPosition: snackPosition ?? SnackPosition.TOP,
      messageText: Text(
        description,
        textAlign: TextAlign.right,
        style: myTextStyles.subTitle.copyWith(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      icon: const Padding(
        padding: EdgeInsets.all(10.0),
        child: FaIcon(
          FontAwesomeIcons.check,
          color: MyColors.containerSecondColor,
          size: 25,
        ),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      borderRadius: 12,
    );
    // Get.snackbar("", "",
    //     barBlur: 0,
    //     overlayBlur: 0,
    //     snackPosition: SnackPosition.BOTTOM,
    //     isDismissible: false,
    //     margin: const EdgeInsets.all(10),
    //     backgroundColor: MyColors.lessBlackColor,
    //     padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    //     duration: const Duration(seconds: 5),
    //     titleText: Text(
    //       "جميع المعاملات المالية ",
    //       textAlign: TextAlign.right,
    //       style: myTextStyles.subTitle.copyWith(
    //         color: Colors.white,
    //       ),
    //     ),
    //     messageText: Padding(
    //       padding: const EdgeInsets.only(bottom: 5),
    //       child: Text("تعني المحاسبة تتبع جميع المعاملات المالية   ",
    //           textAlign: TextAlign.right,
    //           style: myTextStyles.body.copyWith(
    //             color: MyColors.containerColor,
    //           )),
    //     ),
    //     snackStyle: SnackStyle.FLOATING,
    //     shouldIconPulse: true,
    //     icon: const Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 15),
    //       child: FaIcon(
    //         FontAwesomeIcons.check,
    //         color: MyColors.containerSecondColor,
    //         size: 25,
    //       ),
    //     ));
  }

  static void showDialog({title, description, icon, color, action}) {
    Get.defaultDialog(
      title: "",
      titleStyle: myTextStyles.title1,
      middleTextStyle: myTextStyles.subTitle,
      contentPadding: const EdgeInsets.all(20),
      middleText:
          "تعني المحاسبة تتبع جميع المعاملات المالية المتعلقة بالعمل، والتي تتضمن تبويب المدخلات وتسجيلها وتلخيصها وتحليلها وإبلاغ ",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Icon(Icons.dele),
          FaIcon(
            icon,
            color: MyColors.secondaryTextColor,
            size: 50,
          ),
          const SizedBox(height: 20),
          Text(title,
              textAlign: TextAlign.center,
              style: myTextStyles.title1.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: color,
              )),
          // SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: myTextStyles.body,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
      cancel: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            minimumSize: const Size.fromHeight(50),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            action();
          },
          child: Text(
            "موافق",
            style: myTextStyles.title1.copyWith(color: Colors.white),
          )),
      confirm: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 3),
        child: GestureDetector(
          onTap: () => Get.back(),
          child: Text(
            "الغاء",
            style: myTextStyles.subTitle.copyWith(
              color: MyColors.secondaryTextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  static void loadingProgress() {
    Get.defaultDialog(
      title: "...يرجي الإ نتضار",
      middleText: "",
      titleStyle: myTextStyles.subTitle,
      barrierDismissible: false,
      radius: 15,
      titlePadding: const EdgeInsets.all(10),
      // custom: Center(child: CircularProgressIndicator()),
      backgroundColor: MyColors.bg.withOpacity(0.7),
      content: Container(
        constraints: BoxConstraints(
          maxHeight: Get.height / 5,
          maxWidth: Get.width - 50,
        ),
        child: const Center(
            child: CircularProgressIndicator(
          backgroundColor: MyColors.bg,
          color: MyColors.lessBlackColor,
        )),
      ),
    );
  }
}
