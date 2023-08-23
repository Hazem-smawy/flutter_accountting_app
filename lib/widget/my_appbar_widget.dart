import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/pdf_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/screen/settings/acc_group_setting.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class MyAppBarWidget extends StatelessWidget {
  final AccGroup accGroup;
  VoidCallback action;
  MyAppBarWidget({
    super.key,
    required GlobalKey<ScaffoldState> globalKey,
    required this.accGroup,
    required this.action,
  }) : _globalKey = globalKey;

  final GlobalKey<ScaffoldState> _globalKey;
  AccGroupController accGroupController = Get.find();
  AccGroupCurencyController accGroupCurencyController = Get.find();
  PdfApi pdfApi = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            color: MyColors.lessBlackColor,
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(AccGroupCurencyListWidget(
                  goToPageAction: action,
                ));
              },
              child: const FaIcon(
                FontAwesomeIcons.solidFolderClosed,
                size: 20,
                color: MyColors.containerColor,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () async {
                CustomDialog.loadingProgress();
                final file = await PdfApi.generatePdf(
                    homeModel: HomeModel(
                        operation: 20,
                        name: "hazem",
                        caStatus: false,
                        cacStatus: true,
                        totalDebit: 200,
                        totalCredit: 200));
                Get.back();
                await OpenFile.open(file.path);
              },
              child: const FaIcon(
                FontAwesomeIcons.solidFilePdf,
                size: 20,
                color: MyColors.containerColor,
              ),
            ),
            const Spacer(),
            Text(
              accGroupCurencyController.homeReportShow.value
                  ? "إضافي"
                  : accGroupController.allAccGroups
                          .firstWhereOrNull((element) =>
                              element.id ==
                              accGroupCurencyController
                                  .allAccgroupsAndCurency[
                                      accGroupCurencyController
                                          .pageViewCount.value]
                                  .accGroupId)
                          ?.name ??
                      "",
              style:
                  myTextStyles.title2.copyWith(color: MyColors.containerColor),
            ),
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                _globalKey.currentState?.openEndDrawer();
              },
              child: const FaIcon(
                FontAwesomeIcons.bars,
                color: MyColors.containerColor,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccGroupCurencyListWidget extends StatelessWidget {
  AccGroupCurencyListWidget({super.key, required this.goToPageAction});
  AccGroupCurencyController accGroupCurencyController = Get.find();
  AccGroupController accGroupController = Get.find();
  CurencyController curencyController = Get.find();
  VoidCallback goToPageAction;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: 15, top: 55, right: Get.width / 2.3, bottom: Get.height / 2.5),
      width: Get.width / 2,
      //height: 300,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor.withOpacity(0.7),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "كل التصنيفات",
                style: myTextStyles.title2,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      accGroupCurencyController.allAccgroupsAndCurency.length,
                  itemBuilder: (BuildContext context, int index) {
                    var accGroup = accGroupController.allAccGroups.firstWhere(
                      (element) =>
                          element.id ==
                          accGroupCurencyController
                              .allAccgroupsAndCurency[index].accGroupId,
                    );
                    var curency = curencyController.allCurency.firstWhereOrNull(
                      (element) =>
                          element.id ==
                          accGroupCurencyController
                              .allAccgroupsAndCurency[index].curencyId,
                    );
                    return GestureDetector(
                      onTap: () {
                        Get.back();
                        accGroupCurencyController.pageViewCount.value =
                            accGroupCurencyController.allAccgroupsAndCurency
                                .indexWhere(
                          (element) =>
                              element.accGroupId == accGroup.id &&
                              element.curencyId == curency?.id,
                        );
                        goToPageAction();
                      },
                      child: AccGroupCurencyListItemWidget(
                        accGroup: accGroup,
                        curency: curency,
                      ),
                    );
                  },
                ),
              ),
              // const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                  Get.to(() => AccGroupSettingScreen());
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.lessBlackColor.withOpacity(0.9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "اضافه",
                        textAlign: TextAlign.right,
                        style: myTextStyles.subTitle.copyWith(
                          color: MyColors.containerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class AccGroupCurencyListItemWidget extends StatelessWidget {
  AccGroup accGroup;
  Curency? curency;
  AccGroupCurencyListItemWidget({
    super.key,
    required this.accGroup,
    required this.curency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: !accGroup.status || !(curency?.status ?? true)
            ? MyColors.blackColor.withOpacity(0.3)
            : MyColors.containerColor.withOpacity(0.7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textDirection: TextDirection.rtl,
        children: [
          Text(
            accGroup.name,
            textAlign: TextAlign.right,
            style: myTextStyles.title2,
          ),
          const Spacer(),
          if (curency != null)
            Text(
              curency?.name ?? "",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: myTextStyles.subTitle.copyWith(
                fontWeight: FontWeight.normal,
                color: MyColors.blackColor,
              ),
            ),
          if (curency == null)
            const FaIcon(
              FontAwesomeIcons.folderOpen,
              size: 14,
              color: MyColors.secondaryTextColor,
            ),
        ],
      ),
    );
  }
}
