import 'dart:math';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/widget/custom_btns_widges.dart';

import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:account_app/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CurencySettingScreen extends StatelessWidget {
  CurencySettingScreen({super.key});
  CurencyController curencyController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                const CustomBackBtnWidget(title: "العملات"),
                const SizedBox(height: 15),
                if (curencyController.allCurency.isEmpty)
                  EmptyWidget(
                    icon: FontAwesomeIcons.dollarSign,
                    label: "قم بإضافة بعض العملات",
                  ),
                if (curencyController.allCurency.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: DataTable(
                              showCheckboxColumn: true,
                              horizontalMargin: 20,
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                return MyColors.lessBlackColor;
                                // Use the default value.
                              }),
                              columnSpacing: 10,
                              headingRowHeight: 50,
                              headingTextStyle: myTextStyles.title2.copyWith(
                                color: MyColors.bg,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              dataTextStyle: myTextStyles.subTitle.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              decoration: BoxDecoration(
                                  color: MyColors.bg,
                                  borderRadius: BorderRadius.circular(12)),
                              columns: const [
                                DataColumn(label: SizedBox(width: 5)),
                                DataColumn(
                                    label: Expanded(child: Text('الاسم'))),
                                DataColumn(label: Text('الرمز')),
                                DataColumn(
                                    label: Center(
                                  child: Text(
                                    ' الحسابات',
                                  ),
                                )),
                                DataColumn(
                                  label: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ],
                              rows: curencyController.allCurency.map((element) {
                                return DataRow(cells: [
                                  DataCell(GestureDetector(
                                    onTap: () => CustomDialog.showDialog(
                                        title: "تعد يل",
                                        description:
                                            "هل انت متاكد من تعد يل هذه العملة",
                                        color: Colors.green,
                                        icon: FontAwesomeIcons.penToSquare,
                                        action: () {
                                          //edit
                                          if (Get.isDialogOpen == true) {
                                            Get.back();
                                          }
                                          curencyController.newCurency
                                              .addAll(element.toEditMap());
                                          Get.bottomSheet(
                                                  NewCurencySheet(
                                                    isEdding: true,
                                                  ),
                                                  isScrollControlled: true)
                                              .then((value) {
                                            curencyController.newCurency
                                                .clear();
                                          });
                                        }),
                                    child: const FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      size: 17,
                                      color: MyColors.secondaryTextColor,
                                    ),
                                  )),
                                  DataCell(
                                    RichText(
                                        text: TextSpan(
                                            text: element.name,
                                            style: myTextStyles.subTitle)),
                                  ),
                                  DataCell(RichText(
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.ltr,
                                      text: TextSpan(
                                        text: '${element.symbol}',
                                        style: myTextStyles.title2,
                                      ))),
                                  DataCell(Text(
                                    '${customerAccountController.allCustomerAccounts.where((p0) => p0.accgroupId == element.id).toList().length}',
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    textDirection: TextDirection.rtl,
                                  )),
                                  DataCell(CircleAvatar(
                                    backgroundColor: element.status
                                        ? Colors.green
                                        : Colors.red,
                                    radius: 5,
                                  )),
                                ]);
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(NewCurencySheet(), isScrollControlled: true)
              .then((value) {
            curencyController.newCurency.clear();
          });
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class NewCurencySheet extends StatelessWidget {
  NewCurencySheet({super.key, this.isEdding = false});
  final bool isEdding;
  CurencyController curencyController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  @override
  Widget build(BuildContext context) {
    //print(curencyController.newCurency);
    return Obx(
      () => Container(
        //margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: MyColors.bg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomSheetBackBtnWidget(),
            const SizedBox(height: 30),
            const FaIcon(
              FontAwesomeIcons.dollarSign,
              size: 40,
              color: MyColors.secondaryTextColor,
            ),
            const SizedBox(height: 7),
            Text(
              isEdding ? " تعد يل عملة" : "اضافه عملة",
              style: myTextStyles.title1
                  .copyWith(color: MyColors.secondaryTextColor),
            ),
            const SizedBox(height: 20),

            // acc  state
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch.adaptive(
                    value: curencyController.newCurency[CurencyField.status] ??
                        true,
                    onChanged: (newValue) {
                      curencyController.newCurency.update(
                        CurencyField.status,
                        (value) => newValue,
                        ifAbsent: () => newValue,
                      );
                    }),
                Text(
                  "الحالة ",
                  style: myTextStyles.subTitle,
                )
              ],
            ),
            // name
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                    width: Get.width / 3,
                    child: CustomTextFieldWidget(
                      textHint: 'رمز العملة',
                      placeHolder:
                          curencyController.newCurency[CurencyField.symbol],
                      action: (p0) {
                        curencyController.newCurency.update(
                          CurencyField.symbol,
                          (value) => p0,
                          ifAbsent: () => p0,
                        );
                      },
                    )),
                const SizedBox(width: 10),
                Expanded(
                    child: CustomTextFieldWidget(
                  textHint: "الاسم",
                  placeHolder: curencyController.newCurency[CurencyField.name],
                  action: (p0) {
                    curencyController.newCurency.update(
                      CurencyField.name,
                      (value) => p0,
                      ifAbsent: () => p0,
                    );
                  },
                )),
              ],
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
                const SizedBox(width: 10),
                Flexible(
                    child: CustomBtnWidget(
                  color: MyColors.primaryColor,
                  label: "اضافة",
                  action: () async {
                    try {
                      if (curencyController.newCurency[CurencyField.name] !=
                              null &&
                          curencyController.newCurency[CurencyField.symbol] !=
                              null) {
                        if (curencyController
                                    .newCurency[CurencyField.name].length <
                                2 ||
                            curencyController
                                    .newCurency[CurencyField.symbol].length <
                                1) {
                          CustomDialog.customSnackBar(
                              "ادخل كل القيم بطريقة صحيحة", SnackPosition.TOP);

                          return;
                        }
                        var curency = Curency(
                          id: isEdding
                              ? curencyController.newCurency[CurencyField.id]
                              : null,
                          name: curencyController.newCurency[CurencyField.name]
                              .toString()
                              .trim(),
                          symbol:
                              curencyController.newCurency[CurencyField.symbol],
                          status: curencyController
                                  .newCurency[CurencyField.status] ??
                              true,
                          createdAt: isEdding
                              ? DateTime.parse(curencyController
                                  .newCurency[CurencyField.createdAt])
                              : DateTime.now(),
                          modifiedAt: DateTime.now(),
                        );

                        isEdding
                            ? await curencyController.updateCurency(curency)
                            : await curencyController.createCurency(curency);
                        curencyController.readAllCurency();
                      }
                    } catch (e) {}
                  },
                ))
              ],
            ),
            const SizedBox(height: 20),
            if (isEdding && isHasAAccountsOnIt())
              CustomDeleteBtnWidget(
                lable: "حذف العملة",
                action: () {
                  CustomDialog.showDialog(
                      title: "حذف العملة",
                      description: "هل انت متاكد من حذف هذه العملة",
                      color: Colors.red,
                      icon: FontAwesomeIcons.trashCan,
                      action: () {
                        curencyController.deleteCurency(
                            curencyController.newCurency[CurencyField.id]);
                        Get.back();
                        Get.back();
                      });
                },
              ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  bool isHasAAccountsOnIt() {
    var accGoup = customerAccountController.allCustomerAccounts
        .firstWhereOrNull((element) =>
            element.accgroupId ==
            curencyController.newCurency[CurencyField.id]);
    return accGoup == null;
  }
}
