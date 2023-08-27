import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/personal_info/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NoPersonalInfoWidget extends StatelessWidget {
  final bool isDrawer;
  const NoPersonalInfoWidget({super.key, required this.isDrawer});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          FaIcon(
            FontAwesomeIcons.userPlus,
            color: isDrawer ? MyColors.containerColor : MyColors.lessBlackColor,
            size: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            " للحصول علي جميع خدماتنا \nقم بإدخال معلوماتك الشخصية من هنا ",
            textAlign: TextAlign.center,
            style: myTextStyles.subTitle.copyWith(
              color: isDrawer
                  ? MyColors.secondaryTextColor
                  : MyColors.lessBlackColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Get.to(PersonalInfoScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              width: Get.width / 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: MyColors.secondaryTextColor),
              ),
              child: Text(
                "إضافة ",
                style: myTextStyles.title2.copyWith(
                  fontWeight: FontWeight.normal,
                  color: isDrawer
                      ? MyColors.containerColor
                      : MyColors.lessBlackColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
