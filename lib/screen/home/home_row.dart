import 'package:account_app/constant/colors.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/screen/details/details.dart';
import 'package:account_app/screen/new_record/new_record.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeRowView extends StatelessWidget {
  final HomeModel homeModel;
  const HomeRowView({super.key, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 7),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.bg,
        // boxShadow: [myShadow.blackShadow],
      ),
      child: GestureDetector(
        onTap: () => Get.to(() => const DetailsScreen()),
        child: Row(
          children: [
            const SizedBox(width: 5),
            Container(
              width: 25,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.red),
            ),
            const SizedBox(width: 25),
            Text(
              "${homeModel.totalCredit - homeModel.totalDebit}",
              style: myTextStyles.title1.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 25),
            CircleAvatar(
              backgroundColor: MyColors.blackColor.withOpacity(0.9),
              radius: 13,
              child: Text(
                "${homeModel.operation}",
                style: const TextStyle(color: MyColors.bg),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                homeModel.name,
                textAlign: TextAlign.right,
                style: myTextStyles.title2
                    .copyWith(color: MyColors.secondaryTextColor),
              ),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                Get.bottomSheet(const NewRecordScreen(),
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)));
              },
              child: const FaIcon(FontAwesomeIcons.plus, size: 20),
            )
          ],
        ),
      ),
    );
  }
}
