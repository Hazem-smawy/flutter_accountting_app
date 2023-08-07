import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:account_app/constant/colors.dart';
import 'package:get/get.dart';

class HomeSammaryWidget extends StatelessWidget {
  CurencyController curencyController = Get.find();
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  HomeSammaryWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          //  border: Border.all(color: MyColors.shadowColor),
          color: MyColors.bg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 35,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: MyColors.shadowColor,
                  )),
              child: FaIcon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  curencyController.selectedCurency['symbol'],
                  style: myTextStyles.subTitle
                      .copyWith(color: MyColors.secondaryTextColor),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  title,
                  style: myTextStyles.title1,
                ),
              ],
            ),
            Text(
              subTitle,
              style: myTextStyles.body.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
