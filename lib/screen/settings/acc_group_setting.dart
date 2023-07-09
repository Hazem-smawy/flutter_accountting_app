import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_back_button_widget.dart';
import 'package:account_app/widget/custom_button_widget.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccGroupSettingScreen extends StatelessWidget {
  const AccGroupSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const CustomBackBtnWidget(title: "التصنيفات"),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.lessBlackColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5,
                    )),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "عدد الحسابات",
                        style: myTextStyles.title2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text(
                        "التصنيف",
                        textAlign: TextAlign.right,
                        style: myTextStyles.title2.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // list here
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: MyColors.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 5,
                    )),
                    Flexible(
                      flex: 2,
                      child: Text("20", style: myTextStyles.title2),
                    ),
                    Flexible(
                      flex: 2,
                      child: Text("عدد الحسابات",
                          textAlign: TextAlign.right,
                          style: myTextStyles.title2),
                    ),
                  ],
                ),
              ),
              //const Divider(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(NewAccGroupSheet());
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class NewAccGroupSheet extends StatelessWidget {
  const NewAccGroupSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.bg,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const FaIcon(
            FontAwesomeIcons.fileCircleCheck,
            size: 40,
            color: MyColors.secondaryTextColor,
          ),
          const SizedBox(height: 7),
          Text(
            "اضافه تصنيف",
            style: myTextStyles.title1
                .copyWith(color: MyColors.secondaryTextColor),
          ),
          const SizedBox(height: 20),

          // acc  state
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch.adaptive(value: true, onChanged: (newValue) {}),
              Text(
                "الحاله ",
                style: myTextStyles.subTitle,
              )
            ],
          ),
          // name
          SizedBox(height: 10),
          CustomTextFieldWidget(textHint: "الاسم"),
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
