// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/widget/curency_show_widget.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:get/get.dart';

class NewRecordScreen extends StatefulWidget {
  HomeModel homeModel;
  NewRecordScreen({super.key, required this.homeModel});

  @override
  State<NewRecordScreen> createState() => _NewRecordScreenState();
}

class _NewRecordScreenState extends State<NewRecordScreen> {
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

  CurencyController curencyController = Get.find();
  NewAccountController newAccountController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 300,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: MyColors.bg,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // const CustomBackBtnWidget(),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                      width: Get.width / 3,
                      child: CustomTextFieldWidget(
                        textHint: "المبلغ",
                        action: (p0) {
                          newAccountController.newAccount.update(
                            'money',
                            (value) => p0,
                            ifAbsent: () => p0,
                          );
                        },
                      )),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Container(
                    height: 56,
                    padding: const EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.lessBlackColor,
                    ),
                    child: Center(
                      child: Text(
                        widget.homeModel.name,
                        textAlign: TextAlign.right,
                        style:
                            myTextStyles.title2.copyWith(color: Colors.white),
                      ),
                    ),
                  )),
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
                  Expanded(
                      child: CustomTextFieldWidget(
                    textHint: "التفاصل",
                    action: (p0) {
                      newAccountController.newAccount.update(
                        'desc',
                        (value) => p0,
                        ifAbsent: () => p0,
                      );
                    },
                  )),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: MyColors.containerColor.withOpacity(0.5),
                ),
                child: Row(
                  children: [
                    Text(
                      curencyController.allCurency
                          .firstWhere(
                              (element) => element.id == widget.homeModel.curId)
                          .symbol,
                      style: myTextStyles.body,
                    ),
                    Spacer(),
                    Text(
                      curencyController.allCurency
                          .firstWhere(
                              (element) => element.id == widget.homeModel.curId)
                          .name,
                      style: myTextStyles.subTitle,
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                      child: CustomBtnWidget(
                    color: Colors.green,
                    label: "له",
                    action: () {
                      addNewRecordFunction(true);
                    },
                  )),
                  SizedBox(width: 10),
                  Flexible(
                      child: CustomBtnWidget(
                    color: Colors.red,
                    label: "عليه",
                    action: () {
                      addNewRecordFunction(false);
                    },
                  ))
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addNewRecordFunction(bool credit) async {
    if (newAccountController.newAccount['money'] == null ||
        newAccountController.newAccount['desc'] == null) {
      CEC.errorMessage.value = "no data to puplished";
      return;
    }
    newAccountController.newAccount.update(
      "date",
      (value) => _selectedDate,
      ifAbsent: () => _selectedDate,
    );

    if (credit) {
      newAccountController.newAccount.update(
        'credit',
        (value) => double.parse(newAccountController.newAccount['money']),
        ifAbsent: () => double.parse(newAccountController.newAccount['money']),
      );
      newAccountController.newAccount.update(
        'debit',
        (value) => 0.0,
        ifAbsent: () => 0.0,
      );
    } else {
      newAccountController.newAccount.update(
        'debit',
        (value) => double.parse(newAccountController.newAccount['money']),
        ifAbsent: () => double.parse(newAccountController.newAccount['money']),
      );
      newAccountController.newAccount.update(
        'credit',
        (value) => 0.0,
        ifAbsent: () => 0.0,
      );
    }
    newAccountController.addNewRecordToCustomerAccount(widget.homeModel);
  }
}

// class NewCustomerSheet extends StatelessWidget {
//   const NewCustomerSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: MyColors.bg,
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 10,
//           ),
//           child: Column(
//             children: [
//               //   const CustomBackBtnWidget(),
//               const SizedBox(height: 30),
//               Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     //  const FaIcon(
//                     //   FontAwesomeIcons.user,
//                     //   size: 50,
//                     //   color: MyColors.secondaryTextColor,
//                     // ),
//                     // Text(
//                     //   "اضافه عميل",
//                     //   style: myTextStyles.title1,
//                     // ),
//                     const SizedBox(height: 20),
//                     CustomTextFieldWidget(
//                       textHint: "العنوان",
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextFieldWidget(
//                       textHint: "الهاتف",
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Flexible(
//                           child: CustomBtnWidget(
//                             color: MyColors.secondaryTextColor,
//                             label: "الغاء",
//                             action: () {},
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Flexible(
//                           child: CustomBtnWidget(
//                             color: Colors.green,
//                             label: "اضافه",
//                             action: () {},
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
