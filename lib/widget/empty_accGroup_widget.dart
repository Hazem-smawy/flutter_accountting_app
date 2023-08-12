import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/settings/acc_group_setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
              const FaIcon(
                FontAwesomeIcons.folderPlus,
                size: 50,
                color: MyColors.blackColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "قم بإضافة بعض التصنيفات ",
                style: myTextStyles.body,
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => AccGroupSettingScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: MyColors.blackColor,
                            width: 1,
                          )),
                      child: Text(
                        "إضافة",
                        textAlign: TextAlign.center,
                        style: myTextStyles.title1,
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
