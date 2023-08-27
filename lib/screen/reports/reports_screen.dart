import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                padding: EdgeInsets.all(10),
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
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                              SizedBox(
                                width: 10,
                              ),
                              FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        // item tow
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                              SizedBox(
                                width: 10,
                              ),
                              FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // second report item
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                              SizedBox(
                                width: 10,
                              ),
                              FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        ),
                        // item tow
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                              SizedBox(
                                width: 10,
                              ),
                              FaIcon(
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

                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                              SizedBox(
                                width: 10,
                              ),
                              FaIcon(
                                FontAwesomeIcons.fileLines,
                                color: MyColors.secondaryTextColor,
                                size: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    )

                    // second report item
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    SizedBox(
                      width: 15,
                    ),
                    FaIcon(
                      FontAwesomeIcons.clockRotateLeft,
                      color: MyColors.secondaryTextColor,
                      size: 17,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: MyColors.bg,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: MyColors.containerColor,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 20,
                              height: 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColors.creditColor),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Text("r.s"),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "1000",
                              style: myTextStyles.title1,
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Text(
                                  "local",
                                  style: myTextStyles.subTitle,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.solidFolderClosed,
                                  size: 12,
                                  color: MyColors.secondaryTextColor,
                                ),
                              ],
                            ),
                            Spacer(),
                            Text(
                              "hazem smawy",
                              style: myTextStyles.title2,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.lessBlackColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "جميع الحسابات",
                            style: myTextStyles.subTitle.copyWith(
                              color: MyColors.containerColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FaIcon(
                            FontAwesomeIcons.fileCircleCheck,
                            color: MyColors.containerColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.lessBlackColor,
                      ),
                      child: Row(
                        children: [
                          Text(
                            "العملات",
                            style: myTextStyles.subTitle.copyWith(
                              color: MyColors.containerColor,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          FaIcon(
                            FontAwesomeIcons.dollarSign,
                            color: MyColors.containerColor,
                            size: 15,
                          ),
                        ],
                      ),
                    )
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
