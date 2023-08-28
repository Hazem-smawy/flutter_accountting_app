// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:account_app/screen/customer_account/customer_account.dart';
import 'package:account_app/screen/reports/reports_screen_list.dart';
import 'package:account_app/screen/settings/curency_setting.dart';
import 'package:account_app/screen/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';

class HomeReportsScreen extends StatelessWidget {
  const HomeReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: MyColors.containerSecondColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "التقارير",
                        style: myTextStyles.title1,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.bg,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "report of month",
                                style: myTextStyles.subTitle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        // item tow
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.bg,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "report of month",
                                style: myTextStyles.subTitle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // second report item
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.bg,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "report of month",
                                style: myTextStyles.body,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        // item tow
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.bg,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "report of ",
                                style: myTextStyles.subTitle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )

                    // second report item
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "العمليات الحد يثة",
                      style: myTextStyles.subTitle,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const FaIcon(
                      FontAwesomeIcons.clockRotateLeft,
                      color: MyColors.secondaryTextColor,
                      size: 17,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.containerColor,
                  ),
                  child: JournalListWidget(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //  color: MyColors.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SettingScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.lessBlackColor),
                        child: const FaIcon(
                          FontAwesomeIcons.gear,
                          size: 13,
                          color: MyColors.bg,
                        ),
                      ),
                    ),
                    const Spacer(),
                    HomeReportFooterWidget(
                      title: "جميع الحسابات",
                      icon: FontAwesomeIcons.fileCircleCheck,
                      action: () {
                        Get.to(() => CustomerAccountsView());
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    HomeReportFooterWidget(
                      title: "العملات",
                      icon: FontAwesomeIcons.dollarSign,
                      action: () {
                        Get.to(() => CurencySettingScreen());
                      },
                    ),
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

class HomeReportFooterWidget extends StatelessWidget {
  String title;
  IconData icon;
  VoidCallback action;
  HomeReportFooterWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.lessBlackColor,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: myTextStyles.subTitle.copyWith(
                color: MyColors.containerColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            FaIcon(
              icon,
              color: MyColors.containerColor,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
