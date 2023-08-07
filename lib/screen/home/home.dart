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
import 'package:account_app/widget/placeholder_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:account_app/constant/colors.dart';
import 'package:account_app/screen/new_account/new_account.dart';
import 'package:account_app/widget/my_appbar_widget.dart';

class HomeScreen extends StatefulWidget {
  final AccGroup accGroup;
  List<GroupCurency> curencies;
  List? rows;
  HomeScreen(
      {super.key,
      required this.accGroup,
      required this.curencies,
      this.rows = const []});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();

  CurencyController curencyController = Get.find();

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  CustomerAccountController customerAccountController = Get.find();
  double onYou = 0.0;
  double forYou = 0.0;

  void calculateResultMoneyForYou() {
    onYou = 0.0;
    forYou = 0.0;
    widget.rows?.forEach((e) {
      print(e);
      double res = e.totalCredit - e.totalDebit;
      setState(() {
        if (res > 0) {
          onYou += res;
        } else {
          forYou += res;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    calculateResultMoneyForYou();
  }

  @override
  @override
  Widget build(BuildContext context) {
    calculateResultMoneyForYou();
    return Scaffold(
        key: _globalKey,
        backgroundColor: MyColors.containerColor,
        endDrawer: const MyDrawerView(),
        body: SafeArea(
          child: Column(children: [
            const SizedBox(height: 10),
            MyAppBarWidget(
              globalKey: _globalKey,
              accGroup: widget.accGroup,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: widget.rows != null
                  ? HomePrivateSammaryWidget(
                      forYou: forYou,
                      onYou: onYou,
                    )
                  : SizedBox(),
            ),

            Expanded(
              child: widget.rows != null
                  ? ListView.builder(
                      padding: const EdgeInsets.only(
                          bottom: 30, right: 20, left: 20, top: 10),
                      itemCount: widget.rows?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeRowView(
                          homeModel: widget.rows?[index],
                          action: () {
                            homeController
                                .getCustomerAccountsFromCurencyAndAccGroupIds()
                                .then((value) {
                              setState(() {
                                widget.rows = value
                                    .where((element) =>
                                        element.accGId == widget.accGroup.id &&
                                        element.curId ==
                                            curencyController
                                                .selectedCurency['crId'])
                                    .toList();
                              });
                            });
                          },
                        );
                      },
                    )
                  : SizedBox(child: PlaceHolderWidget()),
            ),

            // curency menu
            if (homeController.curency != null)
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: widget.curencies.length > 1
                          ? MyColors.bg
                          : Colors.transparent,
                    ),
                    margin: const EdgeInsets.only(left: 7, bottom: 20),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        widget.curencies.length > 1
                            ? DropdownButton<String>(
                                borderRadius: BorderRadius.circular(15),
                                value: (curencyController
                                            .selectedCurency['name'] ==
                                        null)
                                    ? widget.curencies.first.name
                                    : curencyController.selectedCurency['name'],
                                onChanged: (value) async {
                                  curencyController.selectedCurency.addAll(
                                      widget.curencies
                                          .firstWhere((element) =>
                                              element.name == value)
                                          .toMap());

                                  setState(() {
                                    widget.rows = homeController.loadData
                                        .where((p0) =>
                                            p0.accGId == widget.accGroup.id &&
                                            p0.curId ==
                                                curencyController
                                                    .selectedCurency['crId'])
                                        .toList();
                                  });
                                },
                                alignment: Alignment.center,
                                elevation: 0,
                                isDense: true,
                                itemHeight: kMinInteractiveDimension.toDouble(),
                                dropdownColor: MyColors.secondaryTextColor,
                                underline: Container(
                                  color: Colors.transparent,
                                ),
                                // icon: const Icon(
                                //   Icons.abc,
                                //   color: Colors.black,
                                // ),
                                items: widget.curencies
                                    .map((e) => DropdownMenuItem(
                                          value: e.name,
                                          child: Container(
                                            // padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: MyColors.bg,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(width: 5),
                                                Text(
                                                  e.symbol,
                                                  style: myTextStyles.body
                                                      .copyWith(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        MyColors.lessBlackColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Container(
                                                  width: 1,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: MyColors
                                                        .secondaryTextColor
                                                        .withOpacity(0.7),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  e.name,
                                                  style: myTextStyles.body
                                                      .copyWith(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        MyColors.lessBlackColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList())
                            : widget.curencies.isNotEmpty
                                ? Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: MyColors.bg,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.curencies[0].symbol,
                                          style: myTextStyles.body.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.lessBlackColor,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          width: 1,
                                          height: 15,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: MyColors.secondaryTextColor
                                                .withOpacity(0.7),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          widget.curencies[0].name,
                                          style: myTextStyles.body.copyWith(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.lessBlackColor,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),

            // end curency menu
          ]),
        ));
  }
}

class HomePrivateSammaryWidget extends StatelessWidget {
  final double onYou;
  final double forYou;
  const HomePrivateSammaryWidget({
    super.key,
    required this.onYou,
    required this.forYou,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (forYou != null)
          HomeSammaryWidget(
            icon: FontAwesomeIcons.angleDown,
            title: "$forYou ",
            subTitle: " لك",
            color: Colors.red,
          ),
        SizedBox(
          width: 10,
        ),
        if (onYou != null)
          HomeSammaryWidget(
            icon: FontAwesomeIcons.angleUp,
            title: "$onYou ",
            subTitle: "عليك",
            color: Colors.green,
          )
      ],
    );
  }
}
