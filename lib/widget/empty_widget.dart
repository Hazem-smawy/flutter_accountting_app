import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/image_show.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  String imageName;
  String label;
  EmptyWidget({super.key, required this.imageName, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      width: Get.width - 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        //color: MyColors.bg,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            imageName,
            fit: BoxFit.cover,
            width: Get.width - 100,
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            label,
            style: myTextStyles.title1.copyWith(
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }
}
