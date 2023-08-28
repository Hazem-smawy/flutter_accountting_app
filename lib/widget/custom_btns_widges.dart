import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/pdf_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class CustomBackBtnWidget extends StatelessWidget {
  final String title;
  IconData? icon;
  CustomBackBtnWidget({
    required this.title,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: MyColors.bg,
      ),
      child: Row(
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () async {
                  CustomDialog.loadingProgress();
                  final file = await PdfApi.generatePdf(
                    homeModel: HomeModel(
                        operation: 20,
                        name: "hazem",
                        caStatus: false,
                        cacStatus: true,
                        totalDebit: 200,
                        totalCredit: 200),
                  );
                  Get.back();
                  await OpenFile.open(file.path);
                },
                child: const FaIcon(
                  FontAwesomeIcons.filePdf,
                  size: 20,
                  color: MyColors.lessBlackColor,
                ),
              ),
            ),
          if (icon == null) const SizedBox(width: 20),
          Expanded(
              child: Center(
            child: Text(
              title,
              style: myTextStyles.title1,
            ),
          )),
          GestureDetector(
            onTap: () => Get.back(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: FaIcon(
                FontAwesomeIcons.arrowRightLong,
                color: MyColors.secondaryTextColor,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomDeleteBtnWidget extends StatelessWidget {
  final String lable;
  final VoidCallback action;
  const CustomDeleteBtnWidget(
      {super.key, required this.lable, required this.action});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.red.withOpacity(0.15),
          minimumSize: const Size.fromHeight(50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {
        action();
      },
      child: Text(
        lable,
        style: myTextStyles.title1.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
    );
  }
}

class CustomSheetBackBtnWidget extends StatelessWidget {
  const CustomSheetBackBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: Container(
        width: Get.width / 5,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: MyColors.secondaryTextColor,
        ),
      ),
    );
  }
}

class CustomBtnWidget extends StatelessWidget {
  final Color color;
  final String label;
  final VoidCallback action;

  const CustomBtnWidget({
    Key? key,
    required this.color,
    required this.action,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => action(),
        child: Text(
          label,
          style: myTextStyles.title1.copyWith(
            color: MyColors.background,
          ),
        ));
  }
}

class CustomCopyBtnWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final description;
  VoidCallback action;
  CustomCopyBtnWidget(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.description,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: myTextStyles.subTitle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              action();
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: myTextStyles.title2.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FaIcon(
                    icon,
                    size: 17,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
