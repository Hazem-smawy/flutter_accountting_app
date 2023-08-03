// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/screen/home/home_row.dart';
import 'package:account_app/screen/home/summary_item_widget.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/new_account/new_account.dart';
import 'package:account_app/widget/my_appbar_widget.dart';

class HomeScreen extends StatefulWidget {
  final AccGroup accGroup;
  List<GroupCurency>? curencies;
  List<HomeModel> rows;
  HomeScreen(
      {super.key, required this.accGroup, this.curencies, required this.rows});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();

  CurencyController curencyController = Get.find();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CustomerAccountController customerAccountController = Get.find();

  Future<List<HomeModel>> futureRows = Future.value([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        backgroundColor: MyColors.containerColor,
        endDrawer: const MyDrawerView(),
        body: widget.curencies != null
            ? SafeArea(
                child: Column(children: [
                  const SizedBox(height: 10),
                  MyAppBarWidget(
                    globalKey: _globalKey,
                    accGroup: widget.accGroup,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: HomePrivateSammaryWidget(),
                  ),
                  // Expanded(
                  //   child: FutureBuilder<List<HomeModel>>(
                  //     future: widget.rows,
                  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //       return snapshot.hasData
                  //           ? Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(horizontal: 20),
                  //               child: ListView.builder(
                  //                 padding: const EdgeInsets.only(bottom: 30),
                  //                 itemCount: snapshot.data.length,
                  //                 itemBuilder:
                  //                     (BuildContext context, int index) {
                  //                   return HomeRowView(
                  //                     homeModel: snapshot.data[index],
                  //                   );
                  //                 },
                  //               ),
                  //             )
                  //           : const SizedBox();
                  //     },
                  //   ),
                  // ),
                  Expanded(
                    child: widget.rows.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.only(
                                bottom: 30, right: 15, left: 15),
                            itemCount: widget.rows.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HomeRowView(homeModel: widget.rows[index]);
                            },
                          )
                        : SizedBox(
                            child: Text("no"),
                          ),
                  ),

                  // curency menu
                  if (homeController.curency != null &&
                      widget.curencies!.length > 1)
                    Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.bg,
                          ),
                          margin: const EdgeInsets.only(left: 7, bottom: 20),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Obx(
                                () => DropdownButton<String>(
                                    borderRadius: BorderRadius.circular(15),
                                    value:
                                        (homeController.curency['name'] == null)
                                            ? widget.curencies?.first.name
                                            : homeController.curency['name'],
                                    onChanged: (value) async {
                                      print(widget.accGroup);
                                      homeController.curency.addAll(widget
                                          .curencies!
                                          .firstWhere((element) =>
                                              element.name == value)
                                          .toMap());
                                      futureRows = homeController
                                          .getCustomerAccountsFromCurencyAndAccGroupIds(
                                              widget.accGroup.id!);

                                      // setState(() {
                                      //   widget.rows = futureRows;
                                      //   print(widget.rows);
                                      // });
                                      // customerAccountController
                                      //     .deleteCustomerAccount(21);
                                      // print(
                                      //     "objects : ${customerAccountController.allCustomerAccounts}");
                                    },
                                    alignment: Alignment.center,
                                    elevation: 0,
                                    isDense: true,
                                    itemHeight:
                                        kMinInteractiveDimension.toDouble(),
                                    dropdownColor: MyColors.background,
                                    underline: Container(
                                      color: Colors.transparent,
                                    ),
                                    icon: Icon(
                                      Icons.abc,
                                      color: Colors.white,
                                    ),
                                    items: widget.curencies!
                                        .map((e) => DropdownMenuItem(
                                              value: e.name,
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: MyColors.bg,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      e.symbol,
                                                      style: myTextStyles.body
                                                          .copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: MyColors
                                                            .lessBlackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Container(
                                                      width: 1,
                                                      height: 15,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                        color: MyColors
                                                            .secondaryTextColor
                                                            .withOpacity(0.7),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                    Text(
                                                      e.name,
                                                      style: myTextStyles.body
                                                          .copyWith(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: MyColors
                                                            .lessBlackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 5),
                                                  ],
                                                ),
                                              ),
                                            ))
                                        .toList()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  // end curency menu
                ]),
              )
            : const SizedBox(
                child: Center(
                  child: Text("no curency"),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: MyColors.primaryColor,
          onPressed: () {
            curencyController.selectedCurency.update(
              CurencyField.name,
              (value) => homeController.curency['name'],
              ifAbsent: () => homeController.curency['name'],
            );
            curencyController.selectedCurency.update(
              'id',
              (value) => homeController.curency['crId'],
              ifAbsent: () => homeController.curency['crId'],
            );
            curencyController.selectedCurency.update(
              'symbol',
              (value) => homeController.curency['symbol'],
              ifAbsent: () => homeController.curency['symbol'],
            );
            print(curencyController.selectedCurency);
            Get.bottomSheet(
              NewAccountScreen(
                accGroupId: widget.accGroup,
                curencyId: homeController.curency['crId'],
              ),
              isScrollControlled: true,
            );
            // customerAccountController.acFike();
            //homeController.getCurencyInAccGroup(0);
          },
          child: const FaIcon(FontAwesomeIcons.plus),
        ));
  }
}

class HomePrivateSammaryWidget extends StatelessWidget {
  const HomePrivateSammaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        HomeSammaryWidget(
          icon: FontAwesomeIcons.angleDown,
          title: "1000",
          subTitle: "عليك",
          color: Colors.red,
        ),
        SizedBox(
          width: 10,
        ),
        HomeSammaryWidget(
          icon: FontAwesomeIcons.angleUp,
          title: "2000",
          subTitle: "لك",
          color: Colors.green,
        )
      ],
    );
  }
}
