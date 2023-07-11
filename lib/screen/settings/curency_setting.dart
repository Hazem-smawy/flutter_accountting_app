import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_btns_widges.dart';

import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/custom_textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CurencySettingScreen extends StatelessWidget {
  const CurencySettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              const CustomBackBtnWidget(title: "العملات"),
              const SizedBox(height: 20),
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
                          columnSpacing: 30,
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
                            DataColumn(label: SizedBox(width: 20)),
                            DataColumn(label: Expanded(child: Text('الاسم'))),
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
                          rows: [
                            DataRow(cells: [
                              DataCell(GestureDetector(
                                onTap: () => CustomDialog.showDialog(
                                  title: "تعديل",
                                  description:
                                      "هل انت متاكد من تعديل هذه العمله",
                                  color: Colors.green,
                                  icon: FontAwesomeIcons.penToSquare,
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 17,
                                  color: MyColors.secondaryTextColor,
                                ),
                              )),
                              DataCell(Text(
                                'محلي',
                                style: myTextStyles.title2,
                              )),
                              DataCell(Text(
                                '\$',
                                style: myTextStyles.title2,
                              )),
                              const DataCell(Text(
                                '40',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                              )),
                              const DataCell(CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 5,
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(GestureDetector(
                                onTap: () => CustomDialog.showDialog(
                                  title: "تعديل",
                                  description:
                                      "هل انت متاكد من تعديل هذه العمله",
                                  color: Colors.green,
                                  icon: FontAwesomeIcons.penToSquare,
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 17,
                                  color: MyColors.secondaryTextColor,
                                ),
                              )),
                              DataCell(Text(
                                'دولار',
                                style: myTextStyles.title2,
                              )),
                              DataCell(Text(
                                '\$',
                                style: myTextStyles.title2,
                              )),
                              const DataCell(Text(
                                '40',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                              )),
                              const DataCell(CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 5,
                              )),
                            ]),
                            DataRow(cells: [
                              DataCell(GestureDetector(
                                onTap: () => CustomDialog.showDialog(
                                  title: "تعديل",
                                  description:
                                      "هل انت متاكد من تعديل هذه العمله",
                                  color: Colors.green,
                                  icon: FontAwesomeIcons.penToSquare,
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 17,
                                  color: MyColors.secondaryTextColor,
                                ),
                              )),
                              DataCell(Text(
                                'ريال',
                                style: myTextStyles.title2,
                              )),
                              DataCell(Text(
                                'ري',
                                style: myTextStyles.title2,
                              )),
                              const DataCell(Text(
                                '40',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                              )),
                              const DataCell(CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 5,
                              )),
                            ]),
                          ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(const NewCurencySheet(), isScrollControlled: true);
        },
        backgroundColor: MyColors.primaryColor,
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class NewCurencySheet extends StatelessWidget {
  const NewCurencySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            "اضافه عمله",
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
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                  width: Get.width / 3,
                  child: const CustomTextFieldWidget(textHint: 'رمز العمله')),
              const SizedBox(width: 10),
              const Expanded(child: CustomTextFieldWidget(textHint: "الاسم")),
            ],
          ),
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
          const SizedBox(height: 20),
          const CustomDeleteBtnWidget(
            lable: "حذف العمله",
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
