import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/screen/home/home.dart';
import 'package:account_app/screen/new_account/new_account.dart';
import 'package:account_app/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// class MyMainScreen extends StatelessWidget {
//   MyMainScreen({super.key});
//   CustomerAccountController customerAccountController = Get.find();
//   CustomerController customerController = Get.find();
//   AccGroupController accGroupController = Get.find();
//   CurencyController curencyController = Get.find();
//   HomeController homeController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Obx(
//         () => accGroupController.allAccGroups.isEmpty
//             ? Container()
//             : PageView.builder(
//                 reverse: true,
//                 itemCount: accGroupController.allAccGroups.length,
//                 itemBuilder: ((context, index) {
//                   // print(accGroupController.allAccGroups);
//                   return FutureBuilder<List<GroupCurency>?>(
//                       future: homeController.getCurencyInAccGroup(
//                           accGroupController.allAccGroups[index].id!),
//                       builder: (BuildContext context, AsyncSnapshot snapshot) {
//                         return HomeScreen(
//                           rows: homeController
//                               .getCustomerAccountsFromCurencyAndAccGroupIds(
//                                   accGroupController.allAccGroups[index].id!),
//                           accGroup: accGroupController.allAccGroups[index],
//                           curencies: snapshot.data,
//                         );
//                       });
//                 })),
//       ),
//     ));
//   }
//

class MyMainScreen extends StatefulWidget {
  MyMainScreen({super.key});

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen> {
  CustomerAccountController customerAccountController = Get.find();

  CustomerController customerController = Get.find();

  AccGroupController accGroupController = Get.find();

  CurencyController curencyController = Get.find();

  HomeController homeController = Get.find();
  late List<HomeModel> allMyRows;
  int i = 0;
  @override
  void initState() {
    super.initState();

    allMyRows = homeController.loadData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => accGroupController.allAccGroups.isEmpty
              ? Container()
              : PageView.builder(
                  reverse: true,
                  itemCount: accGroupController.allAccGroups.length,
                  onPageChanged: (value) {
                    setState(() {
                      i = value;
                    });
                  },
                  itemBuilder: ((context, index) {
                    return FutureBuilder<List<GroupCurency>?>(
                        future: homeController.getCurencyInAccGroup(
                            accGroupController.allAccGroups[index].id!),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Obx(
                              () => HomeScreen(
                                rows: allMyRows
                                    .where((p0) =>
                                        p0.accGId ==
                                            accGroupController
                                                .allAccGroups[index].id &&
                                        p0.curId ==
                                            homeController.curency['crId'])
                                    .toList(),
                                accGroup:
                                    accGroupController.allAccGroups[index],
                                curencies: snapshot.data,
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator()),
                            );
                          }
                        });
                  })),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: MyColors.primaryColor,
        onPressed: () {
          Get.bottomSheet(
            NewAccountScreen(
              accGroupId: accGroupController.allAccGroups[i],
              curencyId: homeController.curency['crId'],
            ),
            isScrollControlled: true,
          ).then((value) async {
            setState(() {
              homeController
                  .getCustomerAccountsFromCurencyAndAccGroupIds()
                  .then((value) {
                setState(() {
                  allMyRows = value;
                });
              });
            });
          });
          // customerAccountController.acFike();
          //homeController.getCurencyInAccGroup(0);
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}
