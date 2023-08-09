import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/screen/acc_curency_views/acc_curecy_home.dart';
import 'package:account_app/screen/new_account/new_account.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/drawer_widget.dart';
import 'package:account_app/widget/my_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AccGroupCurencyScreen extends StatelessWidget {
  AccGroupCurencyScreen({super.key});
  AccGroupCurencyController accGroupCurencyController =
      Get.put(AccGroupCurencyController());

  AccGroupController accGroupController = Get.find();

  CurencyController curencyController = Get.find();
  HomeController homeController = Get.find();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      endDrawer: MyDrawerView(
        action: () {},
      ),
      body: SafeArea(
        child:
            Obx(() => accGroupCurencyController.allAccgroupsAndCurency.isEmpty
                ? Column(
                    children: [Text("hellow")],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyAppBarWidget(
                        globalKey: _globalKey,
                        accGroup: accGroupController.allAccGroups
                                .firstWhereOrNull((element) =>
                                    element.id ==
                                    accGroupCurencyController
                                            .allAccgroupsAndCurency[
                                        accGroupCurencyController
                                            .pageViewCount.value]) ??
                            AccGroup(
                                name: "name",
                                status: true,
                                createdAt: DateTime.now(),
                                modifiedAt: DateTime.now()),
                        action: () {},
                      ),
                      Expanded(
                        child: PageView.builder(
                            onPageChanged: (value) {
                              print(value);
                              accGroupCurencyController.pageViewCount.value =
                                  value;
                            },
                            reverse: true,
                            itemCount: accGroupCurencyController
                                .allAccgroupsAndCurency.length,
                            itemBuilder: (context, index) {
                              final accCurIds = accGroupCurencyController
                                  .allAccgroupsAndCurency[index];
                              return Obx(
                                () => AccCurencyHomeScreen(
                                    rows: homeController.loadData
                                        .where((p0) =>
                                            p0.curId == accCurIds.curencyId &&
                                            p0.accGId == accCurIds.accGroupId)
                                        .toList(),
                                    accGroup: accGroupController.allAccGroups
                                        .firstWhere((element) =>
                                            element.id == accCurIds.accGroupId),
                                    stauts: true,
                                    curency: curencyController.allCurency
                                        .firstWhereOrNull((element) =>
                                            element.id == accCurIds.curencyId)),
                              );
                            }),
                      ),
                    ],
                  )),
      ),
      floatingActionButton: Obx(
        () => accGroupController.allAccGroups.isNotEmpty
            ? FloatingActionButton(
                elevation: 0,
                backgroundColor: accGroupController.allAccGroups
                        .firstWhere((element) =>
                            element.id ==
                            accGroupCurencyController
                                .allAccgroupsAndCurency[
                                    accGroupCurencyController
                                        .pageViewCount.value]
                                .accGroupId)
                        .status
                    ? MyColors.primaryColor
                    : MyColors.blackColor,
                onPressed: () {
                  if (accGroupController.allAccGroups
                          .firstWhere((element) =>
                              element.id ==
                              accGroupCurencyController
                                  .allAccgroupsAndCurency[
                                      accGroupCurencyController
                                          .pageViewCount.value]
                                  .accGroupId)
                          .status ==
                      true) {
                    if (accGroupController.allAccGroups.isNotEmpty &&
                        curencyController.allCurency.isNotEmpty) {
                      Get.bottomSheet(
                        NewAccountScreen(
                          accGroupId: accGroupController.allAccGroups[
                              accGroupCurencyController.pageViewCount.value],
                        ),
                        isScrollControlled: true,
                      ).then((value) async {
                        homeController
                            .getCustomerAccountsFromCurencyAndAccGroupIds()
                            .then((value) {});
                      });
                    }
                  } else {
                    CustomDialog.customSnackBar(
                        "هذا التصنيف موقف", SnackPosition.BOTTOM);
                    return;
                  }
                },
                child: const FaIcon(FontAwesomeIcons.plus),
              )
            : SizedBox(),
      ),
    );
  }
}
