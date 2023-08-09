import 'dart:math';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomerSettingScreen extends StatelessWidget {
  CustomerSettingScreen({super.key});
  CustomerController customerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => SingleChildScrollView(
            padding:
                const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 50),
            child: Column(
              children: [
                const CustomBackBtnWidget(title: "العملاء"),
                const SizedBox(height: 20),
                if (customerController.allCustomers.isEmpty)
                  Container(
                    width: Get.width - 50,
                    height: Get.height / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyColors.bg,
                    ),
                  ),
                Column(
                  children: customerController.allCustomers.map((element) {
                    return CustomerSettingItemWidget(
                      customer: element,
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            NewCustomerSheet(),
            isScrollControlled: true,
          ).then((value) {
            customerController.newCustomer.clear();
          });
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class CustomerSettingItemWidget extends StatelessWidget {
  final Customer customer;
  CustomerAccountController customerAccountController = Get.find();
  CustomerSettingItemWidget({
    super.key,
    required this.customer,
  });
  CustomerController customerController = Get.find();
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
              CircleAvatar(
                radius: 5,
                backgroundColor: customer.status ? Colors.green : Colors.red,
              ),
              const Spacer(),
              Text(
                customer.name,
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
                customer.phone,
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
              if (isHasAAccountsOnIt())
                GestureDetector(
                  onTap: () => CustomDialog.showDialog(
                      title: "حذف",
                      description: "هل انت متاكد من حذف هذا الحساب",
                      color: Colors.red,
                      icon: FontAwesomeIcons.trashCan,
                      action: () {
                        customerController.deleteCustomer(customer.id ?? 0);
                        Get.back();
                      }),
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
                    action: () {
                      customerController.newCustomer
                          .addAll(customer.toEditMap());
                      Get.back();
                      Get.bottomSheet(
                        NewCustomerSheet(
                          isEditing: true,
                        ),
                        isScrollControlled: true,
                      ).then((value) {
                        customerController.newCustomer.clear();
                      });
                    }),
                child: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  size: 15,
                  color: Colors.green,
                ),
              ),
              const Spacer(),
              Text(
                customer.address,
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

  bool isHasAAccountsOnIt() {
    var accGoup = customerAccountController.allCustomerAccounts
        .firstWhereOrNull((element) => element.customerId == customer.id);
    return accGoup == null;
  }
}

class NewCustomerSheet extends StatelessWidget {
  final bool isEditing;
  NewCustomerSheet({super.key, this.isEditing = false});
  CustomerController customerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: MyColors.bg,
      ),
      child: Obx(
        () => Column(
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
              "اضافة عميل",
              style: myTextStyles.title1
                  .copyWith(color: MyColors.secondaryTextColor),
            ),
            const SizedBox(height: 20),

            // customer state
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch.adaptive(
                    value:
                        customerController.newCustomer[CustomerField.status] ??
                            true,
                    onChanged: (newValue) {
                      customerController.newCustomer.update(
                        CustomerField.status,
                        (value) => newValue,
                        ifAbsent: () => newValue,
                      );
                    }),
                Text(
                  "حالة العميل",
                  style: myTextStyles.subTitle,
                )
              ],
            ),
            const SizedBox(height: 10),
            // customer name
            Row(
              children: [
                Flexible(
                    child: CustomTextFieldWidget(
                  textHint: "الرقم",
                  placeHolder:
                      customerController.newCustomer[CustomerField.phone] ?? '',
                  action: (p0) {
                    customerController.newCustomer.update(
                      CustomerField.phone,
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                )),
                const SizedBox(width: 10),
                Flexible(
                    child: CustomTextFieldWidget(
                  textHint: "الاسم",
                  placeHolder:
                      customerController.newCustomer[CustomerField.name] ?? '',
                  action: (p0) {
                    customerController.newCustomer.update(
                      CustomerField.name,
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                ))
              ],
            ),
            const SizedBox(height: 10),
            CustomTextFieldWidget(
              textHint: "العنوان",
              placeHolder:
                  customerController.newCustomer[CustomerField.address] ?? "",
              action: (p0) {
                customerController.newCustomer.update(
                  CustomerField.address,
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
                    action: () {},
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                    child: CustomBtnWidget(
                  color: MyColors.primaryColor,
                  label: "اضافة",
                  action: () async {
                    // Customer? curentCustomer =
                    //     customerController.allCustomers.firstWhere(
                    //   (element) =>
                    //       element.name ==
                    //       (customerController.newCustomer[CustomerField.name] ??
                    //           ""),
                    //   orElse: () => Customer(
                    //     id: 1,
                    //     name: 'no',
                    //     phone: 'no',
                    //     address: 'no',
                    //     status: false,
                    //     createdAt: DateTime.now(),
                    //     modifiedAt: DateTime.now(),
                    //   ),
                    // );
                    // if (curentCustomer.name != 'no') {
                    //   CustomDialog.customSnackBar('هذا الاسم موجود من قبل');
                    // } else {
                    try {
                      if (customerController.newCustomer[CustomerField.name] !=
                          null) {
                        var customer = Customer(
                            id: isEditing
                                ? customerController
                                    .newCustomer[CustomerField.id]
                                : null,
                            name: customerController.newCustomer[CustomerField.name]
                                .toString()
                                .trim(),
                            phone: customerController
                                    .newCustomer[CustomerField.phone] ??
                                'لا يوجد رقم',
                            address: customerController
                                    .newCustomer[CustomerField.address] ??
                                "لايوجد عنوان",
                            status: customerController
                                    .newCustomer[CustomerField.status] ??
                                true,
                            createdAt: isEditing
                                ? DateTime.parse(customerController
                                    .newCustomer[CustomerField.createdAt])
                                : DateTime.now(),
                            modifiedAt: DateTime.now());

                        isEditing
                            ? await customerController.updateCustomer(customer)
                            : await customerController.createCusomer(customer);
                      }
                    } catch (e) {
                      //print(e);
                      // CustomDialog.customSnackBar('هذا الاسم موجود من قبل');
                    }
                    // }
                  },
                ))
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
