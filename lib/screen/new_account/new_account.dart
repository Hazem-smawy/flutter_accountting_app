// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:get/get.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen({super.key});

  @override
  State<NewAccountScreen> createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  DateTime _selectedDate = DateTime.now();

  Future _selectDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  _showBottomSheet() {
    Get.bottomSheet(mySheet,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }

  NewCustomerSheet mySheet = Get.put(NewCustomerSheet());
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: Get.height / 2),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: MyColors.bg,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      SizedBox(
                          width: Get.width / 3,
                          child:
                              const CustomTextFieldWidget(textHint: "المبلغ")),
                      const SizedBox(width: 10),
                      const Expanded(
                          child: CustomTextFieldWidget(textHint: "الاسم")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                            height: 56,
                            width: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.containerSecondColor,
                            ),
                            child: const Center(
                                child: FaIcon(
                              FontAwesomeIcons.calendarCheck,
                              color: MyColors.secondaryTextColor,
                              size: 22,
                            ))),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                          child: CustomTextFieldWidget(textHint: "التفاصل")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: const [
                      Flexible(
                          child:
                              CustomBtnWidget(color: Colors.red, label: "له")),
                      SizedBox(width: 10),
                      Flexible(
                          child: CustomBtnWidget(
                              color: Colors.green, label: "عليه"))
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              // Positioned(
              //   top: 80,
              //   right: 0,
              //   left: 0,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(vertical: 10),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       color: MyColors.secondaryTextColor,
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.end,
              //       children: [
              //         ExitCustomerItemWidget(),
              //         ExitCustomerItemWidget(),
              //         ExitCustomerItemWidget(),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExitCustomerItemWidget extends StatelessWidget {
  const ExitCustomerItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "حازم السماوي",
            textAlign: TextAlign.right,
            style: myTextStyles.subTitle.copyWith(
              fontWeight: FontWeight.normal,
              color: MyColors.containerColor,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

class NewCustomerSheet extends StatelessWidget {
  NewCustomerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.bg,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              //   const CustomBackBtnWidget(),
              const SizedBox(height: 30),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  const FaIcon(
                    //   FontAwesomeIcons.user,
                    //   size: 50,
                    //   color: MyColors.secondaryTextColor,
                    // ),
                    // Text(
                    //   "اضافه عميل",
                    //   style: myTextStyles.title1,
                    // ),
                    const SizedBox(height: 20),
                    const CustomTextFieldWidget(
                      textHint: "العنوان",
                    ),
                    const SizedBox(height: 10),
                    const CustomTextFieldWidget(
                      textHint: "الهاتف",
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        Flexible(
                          child: CustomBtnWidget(
                              color: MyColors.secondaryTextColor,
                              label: "الغاء"),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: CustomBtnWidget(
                            color: Colors.green,
                            label: "اضافه",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
