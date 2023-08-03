import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyAppBarWidget extends StatelessWidget {
  final AccGroup accGroup;
  const MyAppBarWidget({
    super.key,
    required GlobalKey<ScaffoldState> globalKey,
    required this.accGroup,
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
                AccCategoriesListSheet(),
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
            accGroup.name,
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
