import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';


class CustomBtnWidget extends StatelessWidget {
  final Color color;
  final String label;

  const CustomBtnWidget({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            minimumSize: Size.fromHeight(56),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {},
        child: Text(
          label,
          style: myTextStyles.title1.copyWith(
            color: MyColors.background,
          ),
        ));
  }
}
