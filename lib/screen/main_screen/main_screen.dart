import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/screen/home/home.dart';
import 'package:account_app/screen/new_account/new_account.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/drawer_widget.dart';
import 'package:account_app/widget/empty_accGroup_widget.dart';
import 'package:account_app/widget/my_appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MyMainScreen extends StatelessWidget {
  MyMainScreen({super.key});
  AccGroupCurencyController accGroupCurencyController = Get.find();

  AccGroupController accGroupController = Get.find();

  CurencyController curencyController = Get.find();
  HomeController homeController = Get.find();
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      endDrawer: MyDrawerView(),
      body: SafeArea(
        child: Obx(() =>
            accGroupCurencyController.allAccgroupsAndCurency.isEmpty &&
                    curencyController.allCurency.isEmpty
                ? EmptyAccGroupsWidget()
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MyAppBarWidget(
                        action: () {
                          controller.animateToPage(
                              accGroupCurencyController.pageViewCount.value,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
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
                      ),
                      Expanded(
                        child: PageView.builder(
                            controller: controller,
                            onPageChanged: (value) {
                              accGroupCurencyController.pageViewCount.value =
                                  value;

                              Curency? selectedCurency = curencyController
                                  .allCurency
                                  .firstWhereOrNull((element) =>
                                      element.id ==
                                      accGroupCurencyController
                                          .allAccgroupsAndCurency[value]
                                          .curencyId);
                              curencyController.selectedCurency
                                  .addAll(selectedCurency?.toEditMap() ?? {});
                            },
                            reverse: true,
                            itemCount: accGroupCurencyController
                                .allAccgroupsAndCurency.length,
                            itemBuilder: (context, index) {
                              final accCurIds = accGroupCurencyController
                                  .allAccgroupsAndCurency[index];
                              return Obx(
                                () => HomeScreen(
                                    rows: homeController.loadData
                                        .where((p0) =>
                                            p0.curId == accCurIds.curencyId &&
                                            p0.accGId == accCurIds.accGroupId)
                                        .toList(),
                                    accGroup: accGroupController.allAccGroups
                                        .firstWhere((element) =>
                                            element.id == accCurIds.accGroupId),
                                    stauts: accGroupController.allAccGroups
                                            .firstWhere((element) =>
                                                element.id ==
                                                accGroupCurencyController
                                                    .allAccgroupsAndCurency[accGroupCurencyController
                                                        .pageViewCount.value]
                                                    .accGroupId)
                                            .status &&
                                        (curencyController.allCurency.firstWhereOrNull((element) => element.id == accCurIds.curencyId)?.status ?? true),
                                    curency: curencyController.allCurency.firstWhereOrNull((element) => element.id == accCurIds.curencyId)),
                              );
                            }),
                      ),
                    ],
                  )),
      ),
      floatingActionButton: Obx(
        () => accGroupController.allAccGroups.isNotEmpty &&
                accGroupCurencyController.allAccgroupsAndCurency.isNotEmpty
            ? curencyController.allCurency.isEmpty
                ? SizedBox()
                : FloatingActionButton(
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
                              accGroupId: accGroupCurencyController
                                  .allAccgroupsAndCurency[
                                      accGroupCurencyController
                                          .pageViewCount.value]
                                  .accGroupId,
                              curencyId: accGroupCurencyController
                                  .allAccgroupsAndCurency[
                                      accGroupCurencyController
                                          .pageViewCount.value]
                                  .curencyId,
                            ),
                            isScrollControlled: true,
                          ).then((value) async {
                            homeController
                                .getCustomerAccountsFromCurencyAndAccGroupIds();
                            accGroupCurencyController
                                .getAllAccGroupAndCurency()
                                .then((value) {
                              var index = accGroupCurencyController
                                  .allAccgroupsAndCurency
                                  .indexWhere((element) =>
                                      element.accGroupId ==
                                          accGroupCurencyController
                                              .allAccgroupsAndCurency[
                                                  accGroupCurencyController
                                                      .pageViewCount.value]
                                              .accGroupId &&
                                      element.curencyId ==
                                          curencyController
                                              .selectedCurency['id']);
                              if (index > -1) {
                                controller.animateToPage(index,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.linear);
                              }
                            });
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
