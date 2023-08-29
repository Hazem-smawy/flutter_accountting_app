import 'dart:io';

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/screen/customer_account/customer_account.dart';
import 'package:account_app/screen/copy_screen/local_copy.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/no_personal_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/settings/setting_screen.dart';

class MyDrawerView extends StatelessWidget {
  MyDrawerView({super.key});

  PersonalController personalController = Get.find();
  CopyController copyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: Platform.isAndroid ? true : false,
      child: Drawer(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          height: Get.height,
          // margin:
          //     const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: MyColors.bg,
          ),
          child: Column(
            children: [
              // const SizedBox(height: 60),
              Obx(
                () => personalController.newPersonal['name'] == null
                    ? Container(
                        padding: EdgeInsets.only(
                            top: Platform.isAndroid ? 10 : 60, bottom: 20),
                        decoration: const BoxDecoration(
                            color: MyColors.lessBlackColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: const NoPersonalInfoWidget(
                          isDrawer: true,
                        ))
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            top: Platform.isAndroid ? 10 : 60, bottom: 20),
                        decoration: const BoxDecoration(
                            color: MyColors.lessBlackColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          children: [
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
                              personalController.newPersonal['name'],
                              style: myTextStyles.title2.copyWith(
                                color: MyColors.bg,
                              ),
                            ),
                            Text(
                              personalController.newPersonal['email'],
                              style: myTextStyles.subTitle.copyWith(
                                color: MyColors.secondaryTextColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
              ),
              // Divider(
              //   color: MyColors.lessBlackColor.withOpacity(0.5),
              // ),
              const SizedBox(height: 30),
              //drawer items
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  children: [
                    DrawerItemWidget(
                      onPress: () => Get.to(() => CustomerAccountsView()),
                      icon: FontAwesomeIcons.users,
                      title: "حسابات العملاء",
                    ),
                    DrawerItemWidget(
                      onPress: () => Get.to(() => SettingScreen()),
                      icon: FontAwesomeIcons.gear,
                      title: "الاعدادات",
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 5),
                      //  padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColors.lessBlackColor.withOpacity(0.1)),
                      child: Column(
                        children: [
                          DrawerItemWidget(
                            onPress: () => Get.to(() => LocalCopyScreen()),
                            icon: FontAwesomeIcons.download,
                            title: " النسخ الإ حتياطي",
                          ),
                          const SizedBox(
                            height: 21,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              ShortCutCopyWidget(
                                icon: FontAwesomeIcons.download,
                                actoin: () {
                                  CustomDialog.showDialog(
                                      action: () {
                                        copyController.openDatabaseFile();

                                        Get.back();
                                      },
                                      title: "إستعادة",
                                      icon: FontAwesomeIcons.download,
                                      color: Colors.red,
                                      description:
                                          "هل أنت متأكد من إستعادة نسخة ");
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ShortCutCopyWidget(
                                icon: FontAwesomeIcons.upload,
                                actoin: () {
                                  CustomDialog.showDialog(
                                      action: () {
                                        Platform.isAndroid
                                            ? copyController.selectFolder()
                                            : copyController.selectFolderIos();

                                        Get.back();
                                      },
                                      title: "نسخة",
                                      icon: FontAwesomeIcons.upload,
                                      color: Colors.green,
                                      description:
                                          "هل أنت متأكد من عمل نسخة جد يدة");
                                },
                              ),
                              const Spacer(),
                              const Padding(
                                padding: EdgeInsets.only(right: 7),
                                child: FaIcon(
                                  FontAwesomeIcons.solidFolderClosed,
                                  size: 17,
                                  color: MyColors.lessBlackColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          // Divider(),
                          // //google drive copy
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     ShortCutCopyWidget(
                          //       icon: FontAwesomeIcons.upload,
                          //       actoin: () {
                          //         CustomDialog.showDialog(
                          //             action: () {
                          //               Platform.isAndroid
                          //                   ? copyController.openDatabaseFile()
                          //                   : copyController
                          //                       .openDatabaseFileIos();

                          //               Get.back();
                          //             },
                          //             title: "إستعادة",
                          //             icon: FontAwesomeIcons.download,
                          //             color: Colors.red,
                          //             description:
                          //                 "هل أنت متأكد من إستعادة نسخة ");
                          //       },
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //     ShortCutCopyWidget(
                          //       icon: FontAwesomeIcons.download,
                          //       actoin: () {
                          //         CustomDialog.showDialog(
                          //             action: () {
                          //               Platform.isAndroid
                          //                   ? copyController.selectFolder()
                          //                   : copyController.selectFolderIos();

                          //               Get.back();
                          //             },
                          //             title: "نسخة",
                          //             icon: FontAwesomeIcons.download,
                          //             color: Colors.green,
                          //             description:
                          //                 "هل أنت متأكد من عمل نسخة جد يدة");
                          //       },
                          //     ),
                          //     const Spacer(),
                          //     const FaIcon(
                          //       FontAwesomeIcons.googleDrive,
                          //       size: 17,
                          //       color: MyColors.bg,
                          //     ),
                          //     const SizedBox(
                          //       width: 10,
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => LocalCopyScreen()),
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 5),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors.lessBlackColor.withOpacity(0.1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            ShortCutCopyWidget(
                              icon: FontAwesomeIcons.download,
                              actoin: () {
                                CustomDialog.showDialog(
                                    action: () async {
                                      Get.back();
                                      await copyController.getTheLastFile();
                                    },
                                    title: "إستعادة",
                                    icon: FontAwesomeIcons.download,
                                    color: Colors.red,
                                    description:
                                        "هل أنت متأكد من إستعادة نسخة ");
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ShortCutCopyWidget(
                              icon: FontAwesomeIcons.upload,
                              actoin: () {
                                CustomDialog.showDialog(
                                    action: () async {
                                      Get.back();
                                      await copyController.uploadCopy();
                                    },
                                    title: "نسخة",
                                    icon: FontAwesomeIcons.upload,
                                    color: Colors.green,
                                    description:
                                        "هل أنت متأكد من عمل نسخة جد يدة");
                              },
                            ),
                            const Spacer(),
                            const Padding(
                              padding: EdgeInsets.only(right: 7, left: 5),
                              child: FaIcon(
                                FontAwesomeIcons.googleDrive,
                                size: 17,
                                color: MyColors.lessBlackColor,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    DrawerItemWidget(
                      onPress: () => Get.to(() => SettingScreen()),
                      icon: FontAwesomeIcons.circleExclamation,
                      title: " عنا",
                    ),
                    const DrawerItemWidget(
                      icon: FontAwesomeIcons.phone,
                      title: "الاتصال والدعم",
                    ),
                    const DrawerItemWidget(
                      icon: FontAwesomeIcons.question,
                      title: " الاسئله الشائعه",
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(right: 20),
                      onTap: () {
                        SystemNavigator.pop();
                        // closeApp();
                        // print("h");
                      },
                      title: Text(
                        "خروج",
                        textAlign: TextAlign.right,
                        style: myTextStyles.title2.copyWith(
                          color: MyColors.secondaryTextColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: const FaIcon(
                        FontAwesomeIcons.arrowRightToBracket,
                        size: 20,
                        color: MyColors.secondaryTextColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShortCutCopyWidget extends StatelessWidget {
  VoidCallback actoin;
  IconData icon;
  ShortCutCopyWidget({super.key, required this.actoin, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => actoin(),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: MyColors.secondaryTextColor,
            )),
        child: Row(
          children: [
            // Text(
            //   label,
            //   style: myTextStyles.body.copyWith(
            //     color: MyColors.bg,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(
            //   width: 5,
            // ),
            const SizedBox(
              width: 10,
            ),
            FaIcon(
              icon,
              color: MyColors.lessBlackColor,
              size: 14,
            ),
            const SizedBox(
              width: 10,
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
          // color: MyColors.withOpacity(0.8),
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: FaIcon(
        icon,
        size: 20,
        color: MyColors.blackColor.withOpacity(0.8),
      ),
    );
  }
}
