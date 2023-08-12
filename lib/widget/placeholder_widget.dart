import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/screen/settings/curency_setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PlaceHolderWidget extends StatelessWidget {
  PlaceHolderWidget({super.key});
  CurencyController curencyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          if (curencyController.allCurency.isEmpty)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.bg,
              ),
              child: Column(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.dollarSign,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "قم بإضافة بعض العملات ",
                    style: myTextStyles.subTitle.copyWith(
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => CurencySettingScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.red,
                                width: 1,
                              )),
                          child: Text(
                            "إضافة",
                            textAlign: TextAlign.center,
                            style:
                                myTextStyles.title1.copyWith(color: Colors.red),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(
                top: 50, right: 20, left: 20, bottom: Get.height / 3),
            width: double.infinity,
            constraints: BoxConstraints(maxHeight: Get.height / 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: MyColors.bg,
              //boxShadow: [myShadow.blackShadow]
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.userPlus,
                    size: 50,
                    color: MyColors.lessBlackColor.withOpacity(0.8),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "قم بإضافة بعض الحسابات",
                    style: myTextStyles.body,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
