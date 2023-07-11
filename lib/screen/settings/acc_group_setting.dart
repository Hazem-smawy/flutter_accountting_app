import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
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
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          dataTextStyle: myTextStyles.subTitle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: BoxDecoration(
                              color: MyColors.bg,
                              borderRadius: BorderRadius.circular(12)),
                          columns: const [
                            DataColumn(label: SizedBox(width: 20)),
                            DataColumn(label: Expanded(child: Text('الاسم'))),
                            DataColumn(
                                label: Center(
                              child: Text(
                                'عدد الحسابات',
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
                                'التصنيف',
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
              // Container(
              //   padding: const EdgeInsets.all(12),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: MyColors.lessBlackColor,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Flexible(
              //           child: CircleAvatar(
              //         backgroundColor: Colors.green,
              //         radius: 5,
              //       )),
              //       Flexible(
              //         flex: 2,
              //         child: Text(
              //           "عدد الحسابات",
              //           style: myTextStyles.title2.copyWith(
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //       Flexible(
              //         flex: 2,
              //         child: Text(
              //           "التصنيف",
              //           textAlign: TextAlign.right,
              //           style: myTextStyles.title2.copyWith(
              //             color: Colors.white,
              //           ),
              //         ),
              //       ),
              //       Flexible(
              //         flex: 1,
              //         child: SizedBox(
              //           width: 20,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // // list here
              // Container(
              //   padding: const EdgeInsets.all(10),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: MyColors.bg,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       const Flexible(
              //           child: CircleAvatar(
              //         backgroundColor: Colors.green,
              //         radius: 5,
              //       )),
              //       Flexible(
              //         flex: 2,
              //         child: Text("20", style: myTextStyles.title2),
              //       ),
              //       Flexible(
              //         flex: 3,
              //         child: Text(
              //           " الاسم",
              //           textAlign: TextAlign.right,
              //           style: myTextStyles.title2,
              //         ),
              //       ),
              //       Flexible(
              //         flex: 1,
              //         child: GestureDetector(
              //           onTap: () => CustomDialog.showDialog(
              //             title: "تعديل",
              //             description: "هل انت متاكد من تعديل هذا التصنيف",
              //             color: Colors.green,
              //             icon: FontAwesomeIcons.penToSquare,
              //           ),
              //           child: const FaIcon(
              //             FontAwesomeIcons.penToSquare,
              //             size: 20,
              //             color: MyColors.secondaryTextColor,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              //const Divider(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(
            const NewAccGroupSheet(),
            isScrollControlled: true,
          );
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
      margin: const EdgeInsets.only(top: 60),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: MyColors.bg,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSheetBackBtnWidget(),
            const SizedBox(height: 30),
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
            const SizedBox(height: 10),
            const CustomTextFieldWidget(textHint: "الاسم"),
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
            //CustomBtnWidget(color: Colors.red, label: "حذف التصنيف"),
            const CustomDeleteBtnWidget(
              lable: "حذف التصنيف",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
