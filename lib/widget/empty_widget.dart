import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  IconData icon;
  String label;
  EmptyWidget({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: Get.width - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.bg,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            color: MyColors.lessBlackColor,
            size: 30,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            label,
            style: myTextStyles.body,
          )
        ],
      ),
    );
  }
}
