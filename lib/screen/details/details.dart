import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/new_record/new_record.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Column(
            children: [
              const CustomBackBtnWidget(
                title: "حازم السماوي",
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: DataTable(
                          headingRowColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                            return MyColors.lessBlackColor;
                            // Use the default value.
                          }),
                          columnSpacing: 10,
                          headingRowHeight: 45,
                          dataRowHeight: 40,
                          headingTextStyle: myTextStyles.title2.copyWith(
                            color: MyColors.bg,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          dataTextStyle: myTextStyles.subTitle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                          decoration: BoxDecoration(
                              color: MyColors.bg,
                              borderRadius: BorderRadius.circular(12)),
                          columns: const [
                            DataColumn(label: Text('التأريخ')),
                            DataColumn(label: Text('المبلغ')),
                            DataColumn(
                                label: Center(
                              child: Text(
                                '     تفاصيل',
                              ),
                            )),
                            DataColumn(
                                label: FaIcon(
                              FontAwesomeIcons.chevronDown,
                              color: MyColors.bg,
                              size: 18,
                            )),
                            DataColumn(
                              label: Text('الحساب'),
                            ),
                          ],
                          rows: [
                            DataRow(cells: [
                              const DataCell(Text('2020-2-4')),
                              DataCell(Text(
                                '3000',
                                style: myTextStyles.title2,
                              )),
                              const DataCell(Text(
                                'إب هي مدينة ',
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                              )),
                              const DataCell(FaIcon(
                                FontAwesomeIcons.chevronDown,
                                color: Colors.green,
                                size: 18,
                              )),
                              DataCell(Text(
                                '1000  ',
                                textAlign: TextAlign.right,
                                style: myTextStyles.title2,
                              )),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('2020-2-4')),
                              DataCell(Text(
                                '3000',
                                style: myTextStyles.title2,
                              )),
                              const DataCell(Text(
                                'إب هي مدينة ',
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                              )),
                              const DataCell(FaIcon(
                                FontAwesomeIcons.chevronUp,
                                color: Colors.red,
                                size: 18,
                              )),
                              DataCell(Text(
                                '1000  ',
                                textAlign: TextAlign.right,
                                style: myTextStyles.title2,
                              )),
                            ]),
                            DataRow(cells: [
                              const DataCell(Text('2020-2-4')),
                              DataCell(Text(
                                '3000',
                                style: myTextStyles.title2,
                              )),
                              const DataCell(Text(
                                'إب هي مدينة ',
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.clip,
                                textDirection: TextDirection.rtl,
                              )),
                              const DataCell(FaIcon(
                                FontAwesomeIcons.chevronDown,
                                color: Colors.green,
                                size: 18,
                              )),
                              DataCell(Text(
                                '1000',
                                textAlign: TextAlign.left,
                                style: myTextStyles.title2,
                              )),
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: const [
                  DetailsSammaryWidget(
                      icon: FontAwesomeIcons.arrowDown,
                      title: "3000",
                      subTitle: "له",
                      color: Colors.red),
                  SizedBox(width: 5),
                  DetailsSammaryWidget(
                      icon: FontAwesomeIcons.arrowUp,
                      title: "3000",
                      subTitle: "عليه",
                      color: Colors.green),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: Border.all(color: MyColors.shadowColor),
                  color: MyColors.bg,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "\$2000",
                      style: myTextStyles.title1,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: MyColors.shadowColor,
                        ),
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.chevronDown,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColors.primaryColor,
        onPressed: () {
          Get.bottomSheet(const NewRecordScreen());
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class DetailsSammaryWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  final Color color;
  const DetailsSammaryWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subTitle,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: MyColors.shadowColor),
          color: MyColors.bg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FaIcon(
                  icon,
                  size: 10,
                  color: color,
                ),
                const Spacer(),
                Text(
                  "\$$title :",
                  style: myTextStyles.title1,
                ),
                const SizedBox(width: 5),
                Text(
                  '$subTitle',
                  style: myTextStyles.body,
                )
              ],
            ),
            // Text(
            //   subTitle,
            //   style: myTextStyles.body.copyWith(
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
