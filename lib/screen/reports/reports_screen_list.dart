import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/home_controller.dart';

class JournalListWidget extends StatefulWidget {
  JournalListWidget({
    super.key,
  });

  @override
  State<JournalListWidget> createState() => _JournalListWidgetState();
}

class _JournalListWidgetState extends State<JournalListWidget> {
  HomeController homeController = Get.find();
  @override
  void initState() {
    super.initState();
    homeController.getTheTodaysJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeController.todaysJournals.isEmpty
          ? Container(
              margin: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.bg.withOpacity(0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 50,
                    color: MyColors.lessBlackColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "لاتوجد أي عمليات اليوم",
                    style: myTextStyles.subTitle,
                  )
                ],
              ))
          : ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: homeController.todaysJournals.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: MyColors.containerSecondColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: homeController.todaysJournals[index]
                                        ['debit'] >
                                    homeController.todaysJournals[index]
                                        ['credit']
                                ? MyColors.creditColor
                                : MyColors.debetColor),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Text(
                        homeController.todaysJournals[index]['symbol'],
                        style: myTextStyles.body,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: Get.width / 5,
                        child: Text(
                          (homeController.todaysJournals[index]['debit'] -
                                  homeController.todaysJournals[index]
                                      ['credit'])
                              .toString(),
                          style: myTextStyles.title2,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            homeController.todaysJournals[index]['accName'],
                            style: myTextStyles.subTitle,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.folder,
                            size: 12,
                            color: MyColors.secondaryTextColor,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.centerRight,
                        width: Get.width / 5,
                        child: Text(
                          homeController.todaysJournals[index]['name'],
                          style: myTextStyles.title2,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
