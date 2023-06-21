import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_back_button_widget.dart';
import 'package:account_app/widget/custom_button_widget.dart';
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
              Container(
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
                          style: myTextStyles.title2
                              .copyWith(color: MyColors.secondaryTextColor),
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
                        const FaIcon(
                          FontAwesomeIcons.trashCan,
                          size: 15,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 10),
                        const FaIcon(
                          FontAwesomeIcons.penToSquare,
                          size: 15,
                          color: Colors.green,
                        ),
                        const Spacer(),
                        Text(
                          "ibb-mobile",
                          style: myTextStyles.title2
                              .copyWith(color: MyColors.secondaryTextColor),
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
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(const NewCustomerSheet());
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.bg,
      ),
      child: Column(
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
          )
        ],
      ),
    );
  }
}
