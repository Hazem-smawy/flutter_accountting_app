import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomBackBtnWidget extends StatelessWidget {
  final String title;
  const CustomBackBtnWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: MyColors.containerColor,
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          Expanded(
              child: Center(
            child: Text(
              title,
              style: myTextStyles.title1,
            ),
          )),
          GestureDetector(
            onTap: () => Get.back(),
            child: FaIcon(
              FontAwesomeIcons.arrowRightLong,
              color: MyColors.secondaryTextColor,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
