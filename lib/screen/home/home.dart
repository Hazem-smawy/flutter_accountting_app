// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:account_app/screen/home/home_row.dart';
import 'package:account_app/screen/home/summary_item_widget.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/new_account/new_account.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: MyColors.containerColor,
      endDrawer: const MyDrawerView(),
      body: SafeArea(
        child: Column(
          children: [
            MyAppBarWidget(globalKey: _globalKey),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: HomePrivateSammaryWidget(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 30),
                  itemCount: 7,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeRowView(
                      color: index % 2 == 0 ? Colors.red : Colors.green,
                      icon: index % 2 == 0
                          ? FontAwesomeIcons.chevronDown
                          : FontAwesomeIcons.chevronUp,
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 33,
                  // width: Get.width / 5,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  margin: const EdgeInsets.only(left: 20, bottom: 20, top: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.bg,
                    // boxShadow: [myShadow.blackShadow]
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 5),
                      Text(
                        "ر.س",
                        style: myTextStyles.body.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: MyColors.lessBlackColor,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        width: 1,
                        height: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: MyColors.secondaryTextColor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "سعودي",
                        style: myTextStyles.body.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: MyColors.lessBlackColor,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: MyColors.primaryColor,
        onPressed: () {
          Get.bottomSheet(
            const NewAccountScreen(),
            isScrollControlled: true,
          );
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class HomePrivateSammaryWidget extends StatelessWidget {
  const HomePrivateSammaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        HomeSammaryWidget(
          icon: FontAwesomeIcons.angleDown,
          title: "1000",
          subTitle: "عليك",
          color: Colors.red,
        ),
        SizedBox(
          width: 10,
        ),
        HomeSammaryWidget(
          icon: FontAwesomeIcons.angleUp,
          title: "2000",
          subTitle: "لك",
          color: Colors.green,
        )
      ],
    );
  }
}

class MyAppBarWidget extends StatelessWidget {
  const MyAppBarWidget({
    super.key,
    required GlobalKey<ScaffoldState> globalKey,
  }) : _globalKey = globalKey;

  final GlobalKey<ScaffoldState> _globalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.lessBlackColor,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.dialog(
                const AccCategoriesListSheet(),
              );
            },
            child: const FaIcon(
              FontAwesomeIcons.clipboardList,
              size: 20,
              color: MyColors.containerColor,
            ),
          ),
          const Spacer(),
          Text(
            "محلي",
            style: myTextStyles.title2.copyWith(color: MyColors.containerColor),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              _globalKey.currentState?.openEndDrawer();
            },
            child: const FaIcon(
              FontAwesomeIcons.bars,
              color: MyColors.containerColor,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}

class AccCategoriesListSheet extends StatelessWidget {
  const AccCategoriesListSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 15, top: 57, right: Get.width / 2, bottom: Get.height / 2),
      width: Get.width / 2,
      height: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor.withOpacity(0.7),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "كل التصنيفات",
                  style: myTextStyles.title2,
                ),
              ),
              const SizedBox(height: 10),
              const CategorySheetItem(),
              const CategorySheetItem(),
              const CategorySheetItem(),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.lessBlackColor.withOpacity(0.9),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("اضافه",
                        textAlign: TextAlign.right,
                        style: myTextStyles.subTitle.copyWith(
                          color: MyColors.containerColor,
                        )),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class CategorySheetItem extends StatelessWidget {
  const CategorySheetItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor.withOpacity(0.7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "محلي",
            textAlign: TextAlign.right,
            style: myTextStyles.subTitle,
          ),
        ],
      ),
    );
  }
}
