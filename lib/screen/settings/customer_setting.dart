import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_back_button_widget.dart';
import 'package:account_app/widget/custom_button_widget.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomerSettingScreen extends StatelessWidget {
  const CustomerSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const CustomBackBtnWidget(title: "العملاء"),
              const SizedBox(height: 20),
              CustomerSettingItemWidget(),
              CustomerSettingItemWidget(),
              CustomerSettingItemWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            const NewCustomerSheet(),
            isScrollControlled: true,
          );
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class CustomerSettingItemWidget extends StatelessWidget {
  const CustomerSettingItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg,
          boxShadow: [
            myShadow.blackShadow,
          ]),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 5,
                backgroundColor: Colors.green,
              ),
              const Spacer(),
              Text(
                "حازم السماوي",
                style: myTextStyles.title2,
              ),
              const SizedBox(width: 10),
              const FaIcon(
                FontAwesomeIcons.user,
                size: 20,
                color: MyColors.lessBlackColor,
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Spacer(),
              Text(
                "772342424",
                style: myTextStyles.title2.copyWith(
                  color: MyColors.secondaryTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 10),
              const FaIcon(
                FontAwesomeIcons.phone,
                size: 15,
                color: MyColors.secondaryTextColor,
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => CustomDialog.showDialog(
                  title: "حذف",
                  description: "هل انت متاكد من حذف هذا الحساب",
                  color: Colors.red,
                  icon: FontAwesomeIcons.trashCan,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.trashCan,
                  size: 15,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => CustomDialog.showDialog(
                  title: "تعديل",
                  description: "هل انت متاكد من تعديل هذا الحساب",
                  color: Colors.green,
                  icon: FontAwesomeIcons.penToSquare,
                ),
                child: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 15,
                  color: Colors.green,
                ),
              ),
              const Spacer(),
              Text(
                "ibb-mobile",
                style: myTextStyles.title2.copyWith(
                  color: MyColors.secondaryTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(width: 10),
              const FaIcon(
                FontAwesomeIcons.locationPin,
                size: 15,
                color: MyColors.secondaryTextColor,
              )
            ],
          )
        ],
      ),
    );
  }
}

class NewCustomerSheet extends StatelessWidget {
  const NewCustomerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: MyColors.bg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          const FaIcon(
            FontAwesomeIcons.user,
            size: 40,
            color: MyColors.secondaryTextColor,
          ),
          const SizedBox(height: 7),
          Text(
            "اضافه عميل",
            style: myTextStyles.title1
                .copyWith(color: MyColors.secondaryTextColor),
          ),
          const SizedBox(height: 20),

          // customer state
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch.adaptive(value: true, onChanged: (newValue) {}),
              Text(
                "حاله العميل",
                style: myTextStyles.subTitle,
              )
            ],
          ),
          const SizedBox(height: 10),
          // customer name
          Row(
            children: const [
              Flexible(child: CustomTextFieldWidget(textHint: "الرقم")),
              SizedBox(width: 10),
              Flexible(child: CustomTextFieldWidget(textHint: "الاسم"))
            ],
          ),
          const SizedBox(height: 10),
          const CustomTextFieldWidget(textHint: "العنوان"),
          const SizedBox(height: 20),
          Row(
            children: const [
              Flexible(
                child: CustomBtnWidget(
                    color: MyColors.secondaryTextColor, label: "الغاء"),
              ),
              SizedBox(width: 10),
              Flexible(
                  child: CustomBtnWidget(
                      color: MyColors.primaryColor, label: "اضافه"))
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
