import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_back_button_widget.dart';
import 'package:account_app/widget/custom_button_widget.dart';
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
                      borderRadius: BorderRadius.circular(7),
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
                          headingTextStyle:
                              myTextStyles.title2.copyWith(color: MyColors.bg),
                          dataTextStyle: myTextStyles.subTitle.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: BoxDecoration(
                              color: MyColors.containerColor,
                              borderRadius: BorderRadius.circular(7)),
                          columns: const [
                            DataColumn(label: Expanded(child: Text('الاسم'))),
                            DataColumn(label: Text('الرمز')),
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
          Get.bottomSheet(const NewCurencySheet());
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.bg,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
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
                  child: CustomTextFieldWidget(textHint: 'رمز العمله')),
              SizedBox(width: 10),
              Expanded(child: const CustomTextFieldWidget(textHint: "الاسم")),
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
          )
        ],
      ),
    );
  }
}
