import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/new_record/new_record.dart';
import 'package:account_app/constant/text_styles.dart';
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
                            DataRow(
                                onLongPress: () {
                                  Get.dialog(const DetialInfoSheet());
                                },
                                cells: [
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
          Get.bottomSheet(
            const NewRecordScreen(),
            isScrollControlled: true,
          );
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
                  subTitle,
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

class DetialInfoSheet extends StatelessWidget {
  const DetialInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.containerColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "حازم السماوي",
                style: myTextStyles.title1,
              ),
              //Divider(),
              const SizedBox(height: 25),
              Row(
                children: [
                  const SizedBox(width: 5),
                  const FaIcon(
                    FontAwesomeIcons.chevronDown,
                    size: 17,
                    color: Colors.red,
                  ),
                  const Spacer(),
                  Text(
                    "3000",
                    style: myTextStyles.title2,
                  ),
                  const Spacer(),
                  const InfoTitleWidget(
                    title: "المبلغ",
                    icon: FontAwesomeIcons.moneyBill,
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ر.س",
                    style: myTextStyles.subTitle
                        .copyWith(color: MyColors.blackColor),
                  ),
                  Text(
                    "دولار",
                    style: myTextStyles.subTitle,
                  ),
                  const InfoTitleWidget(
                    title: "العمله",
                    icon: FontAwesomeIcons.dollarSign,
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2022-06-22",
                    style: myTextStyles.subTitle
                        .copyWith(color: MyColors.blackColor),
                  ),
                  const InfoTitleWidget(
                    title: "التاريخ",
                    icon: FontAwesomeIcons.calendarCheck,
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "11:00 pm",
                    style: myTextStyles.subTitle
                        .copyWith(color: MyColors.blackColor),
                  ),
                  const InfoTitleWidget(
                    title: "الوقت",
                    icon: FontAwesomeIcons.clock,
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    "التفاصيل",
                    style: myTextStyles.subTitle.copyWith(
                      color: MyColors.blackColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    ' خلال المؤتمر أعلنت تعهدات بتقديم ملياري دولار لدعم الاستجابة الإنسانية في اليمن. والخطة هي أكبر نداء تطلقه ',
                    textAlign: TextAlign.center,
                    maxLines: 4,
                    style: myTextStyles.body,
                  )
                ],
              ),
              //  Divider(),
              const SizedBox(height: 20),
              const Spacer(),

              //  CustomBtnWidget(color: Colors.green, label: "تعديل"),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryColor,
                    elevation: 0,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: Text(
                  "تعد يل",
                  style: myTextStyles.title1.copyWith(
                    color: MyColors.background,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => Get.back(),
                child: Text(
                  "موافق",
                  textAlign: TextAlign.center,
                  style: myTextStyles.subTitle,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoTitleWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const InfoTitleWidget({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: myTextStyles.subTitle,
        ),
        const SizedBox(width: 7),
        Container(
          width: 20,
          alignment: Alignment.center,
          child: FaIcon(
            icon,
            size: 15,
            color: MyColors.secondaryTextColor,
          ),
        ),
      ],
    );
  }
}
