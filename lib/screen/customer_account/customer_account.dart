import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/notification.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as DateFormater;

class CustomerAccountsView extends StatelessWidget {
  CustomerAccountsView({super.key});
  CustomerAccountController customerAccountController =
      Get.put(CustomerAccountController());
  CurencyController curencyController = Get.put(CurencyController());
  CustomerController customerController = Get.put(CustomerController());
  AccGroupController accGroupController = Get.put(AccGroupController());

  @override
  Widget build(BuildContext context) {
    customerAccountController.searchedList.value =
        customerAccountController.allCustomerAccounts;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        // color: MyColors.bg,
                      ),
                      child: TextField(
                        onChanged: (value) {
                          var customerList = customerController.allCustomers
                              .where((p0) => p0.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          customerAccountController.searchedList.value =
                              customerAccountController.allCustomerAccounts
                                  .where((p0) =>
                                      customerList.firstWhereOrNull((element) =>
                                          element.id == p0.customerId) !=
                                      null)
                                  .toList();
                        },
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(25)),
                          fillColor: MyColors.bg,
                          focusColor: Colors.transparent,
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 0,
                          ),
                          hintText: "بحث في حسابات العملاء",
                          hintStyle: myTextStyles.body,
                        ),
                        // style: myTextStyles.subTitle,
                      ),
                    )),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const FaIcon(
                        FontAwesomeIcons.arrowRightLong,
                        color: MyColors.secondaryTextColor,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: customerAccountController.searchedList.isEmpty
                    ? Container(
                        width: double.infinity,
                        height: Get.height / 2,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          //color: MyColors.bg,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/customerAccount1.png",
                              fit: BoxFit.cover,
                              height: Get.height / 3,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "لاتوجد اي حسابات ",
                              style: myTextStyles.title2,
                            ),
                            const Spacer(),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount:
                            customerAccountController.searchedList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var curency = curencyController.allCurency
                              .firstWhere((element) =>
                                  element.id ==
                                  customerAccountController
                                      .searchedList[index].curencyId)
                              .name;
                          var customer = customerController.allCustomers
                              .firstWhereOrNull((element) =>
                                  element.id ==
                                  customerAccountController
                                      .searchedList[index].customerId)
                              ?.name;

                          var accGroup = accGroupController.allAccGroups
                              .firstWhere((element) =>
                                  element.id ==
                                  customerAccountController
                                      .allCustomerAccounts[index].accgroupId)
                              .name;
                          return GestureDetector(
                            onTap: () {
                              Get.bottomSheet(CustomerAccountDetailsSheet(
                                customerAccount: customerAccountController
                                    .allCustomerAccounts[index],
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              margin: const EdgeInsets.only(bottom: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.bg,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 5,
                                        backgroundColor:
                                            customerAccountController
                                                    .searchedList[index].status
                                                ? Colors.green
                                                : Colors.red,
                                      ),
                                      const SizedBox(width: 10),
                                      CustomerAccountItem(
                                          isCustomerName: true,
                                          title: customer ?? "",
                                          icon: FontAwesomeIcons.user),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width: Get.width / 4,
                                        child: CustomerAccountItem(
                                            isCustomerName: false,
                                            title: curency,
                                            icon: FontAwesomeIcons.dollarSign),
                                      ),
                                      CustomerAccountItem(
                                          isCustomerName: false,
                                          title: accGroup,
                                          icon: FontAwesomeIcons.folderClosed),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerAccountDetailsSheet extends StatefulWidget {
  CustomerAccount customerAccount;
  CustomerAccountDetailsSheet({super.key, required this.customerAccount});

  @override
  State<CustomerAccountDetailsSheet> createState() =>
      _CustomerAccountDetailsSheetState();
}

class _CustomerAccountDetailsSheetState
    extends State<CustomerAccountDetailsSheet> {
  CurencyController curencyController = Get.find();

  CustomerController customerController = Get.find();

  AccGroupController accGroupController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  bool status = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      status = widget.customerAccount.status;
    });
  }

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.containerColor,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Switch.adaptive(
                  inactiveThumbColor: Colors.red,
                  inactiveTrackColor: Colors.red,
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                    if (value == false) {
                      CustomDialog.customSnackBar(
                        changeStatusMessageCustomer,
                        SnackPosition.TOP,
                      );
                    }
                  }),
              const Spacer(),
              Text(
                "الحالة",
                style: myTextStyles.subTitle
                    .copyWith(color: status ? Colors.green : Colors.red),
              )
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.red.withOpacity(0.09)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.customerAccount.totalDebit.toString(),
                        style: myTextStyles.title2,
                      ),
                      const SizedBox(width: 10),
                      const FaIcon(
                        FontAwesomeIcons.arrowUp,
                        size: 10,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ": لك",
                        style: myTextStyles.body
                            .copyWith(color: MyColors.blackColor),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.green.withOpacity(0.09)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.customerAccount.totalCredit.toString(),
                        style: myTextStyles.title2,
                      ),
                      const SizedBox(width: 10),
                      const FaIcon(
                        FontAwesomeIcons.arrowUp,
                        size: 10,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        ": عليك",
                        style: myTextStyles.body
                            .copyWith(color: MyColors.blackColor),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SheetItem(
            label: "الاسم",
            value: customerController.allCustomers
                .firstWhere((element) =>
                    element.id == widget.customerAccount.customerId)
                .name,
            icon: FontAwesomeIcons.user,
          ),
          const Divider(),
          SheetItem(
            label: "التصنيف",
            value: accGroupController.allAccGroups
                .firstWhere((element) =>
                    element.id == widget.customerAccount.accgroupId)
                .name,
            icon: FontAwesomeIcons.folderClosed,
          ),
          const Divider(),
          SheetItem(
            label: "العملة",
            value: curencyController.allCurency
                .firstWhere(
                    (element) => element.id == widget.customerAccount.curencyId)
                .name,
            icon: FontAwesomeIcons.dollarSign,
          ),
          const Divider(),
          SheetItem(
            label: "التأريخ",
            value: DateFormater.DateFormat.yMMMMd()
                .format(widget.customerAccount.createdAt),
            icon: FontAwesomeIcons.calendar,
          ),
          const Divider(),
          SheetItem(
            label: "الوقت",
            value: DateFormater.DateFormat.Hms()
                .format(widget.customerAccount.createdAt),
            icon: FontAwesomeIcons.clock,
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () async {
              customerAccountController.updateCustomerAccount(
                  widget.customerAccount.copyWith(status: status));
              homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
              Get.back();
            },
            child: Container(
              height: 45,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.primaryColor.withOpacity(0.4)),
              child: Text(
                "تحد يث",
                style: myTextStyles.title2.copyWith(
                  color: MyColors.blackColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class SheetItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  const SheetItem({
    required this.label,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: myTextStyles.subTitle.copyWith(color: MyColors.blackColor),
        ),
        const Spacer(),
        Text(
          label,
          style: myTextStyles.subTitle.copyWith(fontWeight: FontWeight.normal),
        ),
        const SizedBox(width: 10),
        FaIcon(
          icon,
          size: 15,
        ),
      ],
    );
  }
}

class CustomerAccountItem extends StatelessWidget {
  String title;
  IconData icon;
  final bool isCustomerName;
  CustomerAccountItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.isCustomerName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          title,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: myTextStyles.body.copyWith(
            overflow: TextOverflow.clip,
            color: isCustomerName ? MyColors.lessBlackColor : null,
            fontWeight: isCustomerName ? FontWeight.bold : null,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        FaIcon(
          icon,
          size: 15,
          color: isCustomerName
              ? MyColors.lessBlackColor
              : MyColors.secondaryTextColor,
        ),
      ],
    );
  }
}
