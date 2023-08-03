// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/widget/curency_show_widget.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:get/get.dart';

class NewAccountScreen extends StatefulWidget {
  const NewAccountScreen(
      {super.key, required this.accGroupId, required this.curencyId});
  final accGroupId;
  final curencyId;

  @override
  State<NewAccountScreen> createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  DateTime _selectedDate = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newAccountController.newAccount.clear();
  }

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
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
  }

  NewAccountController newAccountController = Get.put(NewAccountController());
  NewCustomerSheet mySheet = Get.put(NewCustomerSheet());
  CustomerController customerController = Get.find();
  @override
  Widget build(BuildContext context) {
    CEC.errorMessage.value = "";
    return Container(
      //constraints: BoxConstraints(minHeight: Get.height / 2),
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
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (CEC.errorMessage.isNotEmpty) ErrorShowWidget(),
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
                            child: CustomTextFieldWidget(
                          textHint: "الاسم",
                          action: (p0) {
                            newAccountController.newAccount.update(
                              'name',
                              (value) => p0,
                              ifAbsent: () => p0,
                            );
                          },
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
                        SizedBox(width: 10),
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
                    CurencyShowWidget(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                            child: CustomBtnWidget(
                          color: Colors.green,
                          label: "له",
                          action: () {
                            createCustomerAccount(true);
                          },
                        )),
                        SizedBox(width: 10),
                        Flexible(
                            child: CustomBtnWidget(
                          color: Colors.red,
                          label: "عليه",
                          action: () {
                            createCustomerAccount(false);
                          },
                        ))
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
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

  void createCustomerAccount(bool credit) {
    if (newAccountController.newAccount['name'] == null ||
        newAccountController.newAccount['money'] == null ||
        newAccountController.newAccount['desc'] == null) {
      CEC.errorMessage.value = "no data to puplished";
      return;
    }
    newAccountController.newAccount.update(
      "date",
      (value) => _selectedDate,
      ifAbsent: () => _selectedDate,
    );
    newAccountController.newAccount.update(
      "accGroupId",
      (value) => widget.accGroupId.id,
      ifAbsent: () => widget.accGroupId.id,
    );
    newAccountController.newAccount.update(
      "curencyId",
      (value) => widget.curencyId,
      ifAbsent: () => widget.curencyId,
    );

    if (credit) {
      newAccountController.newAccount.update(
        'credit',
        (value) => double.parse(newAccountController.newAccount['money']),
        ifAbsent: () => double.parse(newAccountController.newAccount['money']),
      );
      newAccountController.newAccount.update(
        'credit',
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

    var findCustomer = customerController.allCustomers.firstWhereOrNull(
      (element) => element.name == newAccountController.newAccount['name'],
    );
    if (findCustomer != null) {
      newAccountController.newAccount.update(
        "customerId",
        (value) => findCustomer.id,
        ifAbsent: () => findCustomer.id,
      );
      newAccountController.createNewCustomerAccount();
    } else {
      _showBottomSheet();
    }
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
  NewAccountController newAccountController = Get.find();
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
            mainAxisSize: MainAxisSize.min,
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
                    CustomTextFieldWidget(
                      textHint: "العنوان",
                      action: (p0) {
                        newAccountController.newAccount.update(
                          'address',
                          (value) => p0,
                          ifAbsent: () => p0,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomTextFieldWidget(
                      textHint: "الهاتف",
                      action: (p0) {
                        newAccountController.newAccount.update(
                          'phone',
                          (value) => p0,
                          ifAbsent: () => p0,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Flexible(
                          child: CustomBtnWidget(
                            color: MyColors.secondaryTextColor,
                            label: "الغاء",
                            action: () {
                              Get.back();
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: CustomBtnWidget(
                            color: Colors.green,
                            label: "اضافه",
                            action: () {
                              newAccountController.newAccount.update(
                                "new",
                                (value) => true,
                                ifAbsent: () => true,
                              );
                              newAccountController.createNewCustomerAccount();
                            },
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
