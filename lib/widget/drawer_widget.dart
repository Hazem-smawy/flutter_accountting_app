
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/settings/setting_screen.dart';

class MyDrawerView extends StatelessWidget {
  const MyDrawerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        height: Get.height,
        margin:
            const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: MyColors.lessBlackColor,
        ),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const CircleAvatar(
              radius: 30,
              backgroundColor: MyColors.containerColor,
              child: FaIcon(
                FontAwesomeIcons.user,
                size: 20,
                color: MyColors.lessBlackColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "حازم السماوي",
              style: myTextStyles.title1.copyWith(
                color: MyColors.containerColor,
              ),
            ),
            Text(
              "hazemsmawy@gmail.com",
              style: myTextStyles.title1.copyWith(
                color: MyColors.secondaryTextColor,
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: MyColors.containerColor.withOpacity(0.5),
            ),
            const SizedBox(height: 30),
            //drawer items
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  DrawerItemWidget(
                    onPress: () => Get.to(() => const SettingScreen()),
                    icon: FontAwesomeIcons.gear,
                    title: "الاعدادات",
                  ),
                  DrawerItemWidget(
                    onPress: () => Get.to(() => const SettingScreen()),
                    icon: FontAwesomeIcons.circleExclamation,
                    title: " عنا",
                  ),
                  const DrawerItemWidget(
                    icon: FontAwesomeIcons.question,
                    title: " الاسئله الشائعه",
                  ),
                  const DrawerItemWidget(
                    icon: FontAwesomeIcons.phone,
                    title: "الاتصال والدعم",
                  ),
                  //Spacer(),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 300,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "خروج",
                      textAlign: TextAlign.right,
                      style: myTextStyles.title2.copyWith(
                        color: Colors.red.withOpacity(0.8),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.arrowRightToBracket,
                      size: 20,
                      color: Colors.red.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onPress;
  const DrawerItemWidget({
    Key? key,
    this.onPress,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (onPress != null) {
          onPress!();
        }
      },
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: myTextStyles.title2.copyWith(
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: FaIcon(
        icon,
        size: 20,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
}