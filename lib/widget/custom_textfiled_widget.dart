import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String textHint;
  Function(String)? action;
  String? placeHolder;

  CustomTextFieldWidget({
    required this.textHint,
    this.action,
    this.placeHolder = "",
    super.key,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerSecondColor,
      ),
      child: TextFormField(
        initialValue: widget.placeHolder ?? "",
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: myTextStyles.subTitle.copyWith(color: MyColors.blackColor),
        onChanged: (value) {
          if (widget.action != null) {
            widget.action!(value);
            CEC.errorMessage.value = "";
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.textHint,
            hintStyle: myTextStyles.body,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class CustomNumberFieldWidget extends StatefulWidget {
  final String textHint;
  Function(String)? action;
  String? placeHolder;

  CustomNumberFieldWidget({
    required this.textHint,
    this.action,
    this.placeHolder = "",
    super.key,
  });

  @override
  State<CustomNumberFieldWidget> createState() =>
      _CustomNumberFieldWidgetState();
}

class _CustomNumberFieldWidgetState extends State<CustomNumberFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      alignment: Alignment.center,
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerSecondColor,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: widget.placeHolder ?? "",
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: myTextStyles.subTitle.copyWith(color: MyColors.blackColor),
        onChanged: (value) {
          if (widget.action != null) {
            widget.action!(value);
            CEC.errorMessage.value = "";
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.textHint,
            hintStyle: myTextStyles.body,
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}
