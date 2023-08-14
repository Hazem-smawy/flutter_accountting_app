// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/widget/curency_show_widget.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  List<Customer> customers = [];
  Customer? selectionCustomer;
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

  bool isFindedIt = false;

  NewAccountController newAccountController = Get.find();
  NewCustomerSheet mySheet = Get.put(NewCustomerSheet());
  CustomerController customerController = Get.find();
  HomeController homeController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  CurencyController curencyController = Get.find();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CEC.errorMessage.value = "";
    return Container(
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
                    if (CEC.errorMessage.isNotEmpty) const ErrorShowWidget(),
                    if (isFindedIt) const CorrectShowWidget(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SizedBox(
                            width: Get.width / 3,
                            child: CustomNumberFieldWidget(
                              textHint: "المبلغ",
                              action: (p0) {
                                setState(() {
                                  customers.clear();
                                });
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
                          height: 55,
                          alignment: Alignment.center,
                          //padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: MyColors.containerSecondColor,
                          ),
                          child: TextFormField(
                            controller: nameController,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: myTextStyles.subTitle.copyWith(
                                color: MyColors.blackColor,
                                fontWeight: FontWeight.bold),
                            onChanged: (p0) {
                              selectionCustomer = null;
                              CEC.errorMessage.value = "";
                              newAccountController.newAccount.update(
                                'name',
                                (value) => p0,
                                ifAbsent: () => p0,
                              );
                              if (p0.length > 0) {
                                setState(() {
                                  customers = customerController.allCustomers
                                      .where((element) => element.name
                                          .contains(p0.toString().trim()))
                                      .toList();
                                });
                              } else {
                                setState(() {
                                  customers.clear();
                                });
                              }
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "الاسم",
                                hintStyle: myTextStyles.body
                                    .copyWith(fontWeight: FontWeight.normal),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10)),
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
              if (customers.isNotEmpty)
                Positioned(
                  top: 80,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyColors.secondaryTextColor.withOpacity(0.7),
                    ),
                    child: ListView.builder(
                      itemCount: customers.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return ExitCustomerItemWidget(
                          customer: customers[index],
                          action: () {
                            setState(() {
                              selectionCustomer = customers[index];
                              nameController.text = customers[index].name;
                              customers.clear();
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  /*


Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: customers
                          .map((e) => ExitCustomerItemWidget(
                                customer: e,
                                action: () {
                                  setState(() {
                                    selectionCustomer = e;
                                    nameController.text = e.name;
                                    customers.clear();
                                  });
                                },
                              ))
                          .toList(),
                    ),
  */

  void createCustomerAccount(bool credit) async {
    if (nameController.text.length < 1) {
      CEC.errorMessage.value = "قم يملئ حقل الاسم بطريقة صحيحة";
      return;
    }
    if (selectionCustomer != null) {
      newAccountController.newAccount.update(
        "name",
        (value) => selectionCustomer?.name,
        ifAbsent: () => selectionCustomer?.name,
      );
    } else {
      newAccountController.newAccount.update(
        "name",
        (value) => nameController.text.trim(),
        ifAbsent: () => nameController.text.trim(),
      );
    }
    if (newAccountController.newAccount['name'] == null ||
        newAccountController.newAccount['money'] == null ||
        newAccountController.newAccount['desc'] == null) {
      CEC.errorMessage.value = "no data to puplished";
      return;
    }
    if (newAccountController.newAccount['money'].length < 1 ||
        newAccountController.newAccount['desc'].length < 2) {
      CEC.errorMessage.value = "no data to puplished";
      return;
    }

    if (curencyController.allCurency
            .firstWhereOrNull((element) =>
                element.id == curencyController.selectedCurency['crId'])
            ?.status ==
        false) {
      CustomDialog.customSnackBar("لم تقم بتحديد العمله", SnackPosition.BOTTOM);
      return;
    }

    newAccountController.newAccount.update(
      "date",
      (value) => _selectedDate,
      ifAbsent: () => _selectedDate,
    );
    newAccountController.newAccount.update(
      "accGroupId",
      (value) => widget.accGroupId,
      ifAbsent: () => widget.accGroupId,
    );
    // newAccountController.newAccount.update(
    //   "curencyId",
    //   (value) => widget.curencyId,
    //   ifAbsent: () => widget.curencyId,
    // );
    try {
      if (credit) {
        newAccountController.newAccount.update(
          'credit',
          (value) => double.parse(newAccountController.newAccount['money']),
          ifAbsent: () =>
              double.parse(newAccountController.newAccount['money']),
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
          ifAbsent: () =>
              double.parse(newAccountController.newAccount['money']),
        );
        newAccountController.newAccount.update(
          'credit',
          (value) => 0.0,
          ifAbsent: () => 0.0,
        );
      }
    } catch (e) {
      CEC.errorMessage.value = "قم بإدخال الحقول بشكل صحيح";
      return;
    }

    var findCustomer = customerController.allCustomers.firstWhereOrNull(
      (element) =>
          element.name ==
          newAccountController.newAccount['name'].toString().trim(),
    );
    if (findCustomer != null) {
      newAccountController.newAccount.update(
        "customerId",
        (value) => findCustomer.id,
        ifAbsent: () => findCustomer.id,
      );

      newAccountController.createNewCustomerAccount();
    } else {
      if (findCustomer?.status == false) {
        CustomDialog.customSnackBar("هذا الحساب موقف", SnackPosition.BOTTOM);
        return;
      }
      _showBottomSheet();
    }
  }

  Future<CustomerAccount?> getCustomerAccountStatus(int customerId) async {
    var cac = customerAccountController.findCustomerAccountIfExist(
        cid: customerId,
        accg: newAccountController.newAccount['accGroupId'],
        curid: curencyController.selectedCurency['id']);
    return cac;
  }
}

class ExitCustomerItemWidget extends StatelessWidget {
  Customer customer;
  VoidCallback action;

  ExitCustomerItemWidget(
      {super.key, required this.customer, required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor,
      ),
      child: GestureDetector(
        onTap: () {
          action();
        },
        child: Text(
          customer.name,
          textAlign: TextAlign.right,
          style: myTextStyles.subTitle.copyWith(
            fontWeight: FontWeight.bold,
            color: MyColors.blackColor,
          ),
        ),
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
                      textHint: "الهاتف",
                      action: (p0) {
                        newAccountController.newAccount.update(
                          'phone',
                          (value) => p0,
                          ifAbsent: () => p0,
                        );
                      },
                    ),
                    const SizedBox(height: 10),

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
