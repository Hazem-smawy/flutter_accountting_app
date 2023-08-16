// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/screen/personal_info/personal_info.dart';
import 'package:account_app/screen/settings/acc_group_setting.dart';
import 'package:account_app/screen/settings/curency_setting.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/no_personal_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/settings/customer_setting.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  PersonalController personalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.lessBlackColor,
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: MyColors.lessBlackColor,
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Expanded(
                              child: Text(
                            "الا عدادات",
                            textAlign: TextAlign.center,
                            style: myTextStyles.title1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              // fontSize: 18,
                            ),
                          )),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: FaIcon(
                                FontAwesomeIcons.arrowRightLong,
                                color: Colors.white54,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Get.to(() => PersonalInfoScreen()),
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8,
                          bottom: 12,
                          top: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.bg,
                        ),
                        child: Obx(
                          () => personalController.newPersonal['name'] == null
                              ? const NoPersonalInfoWidget(
                                  isDrawer: false,
                                )
                              : Row(
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const FaIcon(
                                      FontAwesomeIcons.chevronLeft,
                                      size: 15,
                                      color: MyColors.secondaryTextColor,
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          personalController
                                              .newPersonal['name'],
                                          style: myTextStyles.title1.copyWith(
                                            // color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          personalController
                                              .newPersonal['email'],
                                          style: myTextStyles.title1.copyWith(
                                            //  color: Colors.white54,
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 15),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        const CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              MyColors.secondaryTextColor,
                                          child: FaIcon(
                                            FontAwesomeIcons.user,
                                            color: MyColors.containerColor,
                                          ),
                                        ),
                                        Positioned(
                                          bottom: -10,
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green,
                                            ),
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            child: const Center(
                                              child: FaIcon(
                                                FontAwesomeIcons.plus,
                                                size: 13,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                    //const SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: MyColors.bg,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        SettingItemWidget(
                          onPress: () => Get.to(() => CustomerSettingScreen()),
                          icon: FontAwesomeIcons.users,
                          title: "كل العملاء",
                        ),
                        SettingItemWidget(
                          onPress: () => Get.to(() => CurencySettingScreen()),
                          icon: FontAwesomeIcons.dollarSign,
                          title: "العملات",
                        ),
                        SettingItemWidget(
                          onPress: () => Get.to(() => AccGroupSettingScreen()),
                          icon: FontAwesomeIcons.fileCirclePlus,
                          title: " التصنيفات",
                        ),

                        //theme
                        const SizedBox(height: 30),
                        const Spacer(),
                        Container(
                          width: Get.width - 100,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.containerColor,
                          ),
                          child: Text(
                            "خروج ",
                            style: myTextStyles.subTitle,
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItemWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPress;
  const SettingItemWidget({
    Key? key,
    required this.title,
    required this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPress != null) {
          onPress!();
        }
      },
      child: Container(
          margin: const EdgeInsets.only(top: 5.0),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: MyColors.containerColor.withOpacity(0.3),
          ),
          child: Row(children: [
            const SizedBox(width: 5),
            const Padding(
              padding: EdgeInsets.all(5),
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: 15,
                color: Colors.black45,
              ),
            ),
            const Spacer(),
            Text(
              title,
              textAlign: TextAlign.right,
              style: myTextStyles.title2.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 35,
              height: 35,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(10),
                color: MyColors.lessBlackColor.withOpacity(0.8),
              ),
              child: Center(
                child: FaIcon(
                  icon,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ])),
    );
  }
}
