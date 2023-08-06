import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: 20, right: 20, left: 20, bottom: Get.height / 3),
      width: double.infinity,
      constraints: BoxConstraints(maxHeight: Get.height / 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg,
          boxShadow: [myShadow.blackShadow]),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.folderClosed,
              size: 50,
              color: MyColors.blackColor.withOpacity(0.8),
            ),
            Text(
              "there is no any account here",
              style: myTextStyles.body,
            )
          ],
        ),
      ),
    );
  }
}
