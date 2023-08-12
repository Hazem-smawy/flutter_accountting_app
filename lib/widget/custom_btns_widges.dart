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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: MyColors.bg,
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
              child: Center(
            child: Text(
              title,
              style: myTextStyles.title1,
            ),
          )),
          GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: FaIcon(
                FontAwesomeIcons.arrowRightLong,
                color: MyColors.secondaryTextColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomDeleteBtnWidget extends StatelessWidget {
  final String lable;
  final VoidCallback action;
  const CustomDeleteBtnWidget(
      {super.key, required this.lable, required this.action});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.red.withOpacity(0.15),
          minimumSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {
        action();
      },
      child: Text(
        lable,
        style: myTextStyles.title1.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}

class CustomSheetBackBtnWidget extends StatelessWidget {
  const CustomSheetBackBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: Get.width / 5,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.secondaryTextColor,
        ),
      ),
    );
  }
}

class CustomBtnWidget extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback action;

  const CustomBtnWidget({
    Key? key,
    required this.color,
    required this.action,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () => action(),
        child: Text(
          label,
          style: myTextStyles.title1.copyWith(
            color: MyColors.background,
          ),
        ));
  }
}
