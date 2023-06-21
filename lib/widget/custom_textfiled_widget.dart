import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String textHint;

  const CustomTextFieldWidget({
    required this.textHint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerSecondColor,
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: myTextStyles.title1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: textHint,
          hintStyle: myTextStyles.subTitle,
        ),
      ),
    );
  }
}
