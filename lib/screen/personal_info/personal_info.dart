import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_back_button_widget.dart';
import 'package:account_app/widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const CustomBackBtnWidget(title: "المعلومات الشخصيه"),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.bg,
                  boxShadow: [myShadow.blackShadow]),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const FaIcon(
                      //   FontAwesomeIcons.penToSquare,
                      //   size: 15,
                      //   color: Colors.green,
                      // ),
                      // Spacer(),
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: MyColors.lessBlackColor,
                        child: FaIcon(
                          FontAwesomeIcons.house,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
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
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Get.bottomSheet(const EditPersonalInfoSheet(),
                              isScrollControlled: true);
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.penToSquare,
                          size: 15,
                          color: Colors.green,
                        ),
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
      )),
    );
  }
}

class EditPersonalInfoSheet extends StatelessWidget {
  const EditPersonalInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: EdgeInsets.only(top: Get.width / 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            color: MyColors.bg),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 7,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.blackColor,
                ),
              ),
              const SizedBox(height: 50),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: MyColors.lessBlackColor,
                    child: FaIcon(
                      FontAwesomeIcons.house,
                      color: Colors.white,
                    ),
                  ),
                  const Positioned(
                      child: CircleAvatar(
                    radius: 12,
                    backgroundColor: MyColors.primaryColor,
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      color: MyColors.bg,
                      size: 15,
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 30),
              const PersonalTextFieldWidget(
                textHint: "الاسم",
                icon: FontAwesomeIcons.user,
              ),
              const SizedBox(height: 10),
              const PersonalTextFieldWidget(
                textHint: "الرقم",
                icon: FontAwesomeIcons.phone,
              ),
              const SizedBox(height: 10),
              const PersonalTextFieldWidget(
                  textHint: "العنوان", icon: FontAwesomeIcons.locationPin),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Flexible(
                      child: CustomBtnWidget(
                          color: MyColors.secondaryTextColor, label: "الغاء")),
                  const SizedBox(width: 10),
                  const Flexible(
                      child: CustomBtnWidget(
                    color: MyColors.primaryColor,
                    label: 'اضافه',
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalTextFieldWidget extends StatelessWidget {
  final String textHint;
  final IconData icon;
  const PersonalTextFieldWidget(
      {super.key, required this.icon, required this.textHint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.containerSecondColor,
      ),
      child: Row(
        children: [
          Expanded(
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
          ),
          const SizedBox(width: 10),
          FaIcon(
            icon,
            size: 20,
            color: MyColors.secondaryTextColor,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
