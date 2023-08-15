import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/settings/acc_group_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyAccGroupsWidget extends StatelessWidget {
  const EmptyAccGroupsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/accGroup.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "قم بإضافة بعض التصنيفات ",
                style: myTextStyles.title1.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                  // padding: const EdgeInsets.symmetric(horizontal: 80),
                  child: GestureDetector(
                onTap: () {
                  Get.to(() => AccGroupSettingScreen());
                },
                child: Container(
                  width: Get.width / 3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: MyColors.lessBlackColor.withOpacity(0.5),
                        width: 1,
                      )),
                  child: Text(
                    "إضافة",
                    textAlign: TextAlign.center,
                    style: myTextStyles.title2,
                  ),
                ),
              )),
            ],
          ),
        ));
  }
}
