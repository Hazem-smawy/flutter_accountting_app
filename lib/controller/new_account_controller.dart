import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/models/home_model.dart';

import 'package:account_app/models/journal_model.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class NewAccountController extends GetxController {
  var newAccount = {}.obs;
  CustomerController customerController = Get.find();
  JournalController journalController = Get.find();
  CurencyController curencyController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  HomeController homeController = Get.find();
  AccGroupCurencyController accGroupCurencyController = Get.find();
  Future<void> createNewCustomerAccount() async {
    print(newAccount);
    print(curencyController.selectedCurency);
    if (curencyController.selectedCurency['status'] == false) {
      CustomDialog.customSnackBar("قم بإختيار العملة", SnackPosition.BOTTOM);
      return;
    }
    final int? customerId;
    if (newAccount['new'] != null) {
      var newCustomer = Customer(
        name: newAccount['name'].toString().trim(),
        phone: newAccount['phone'] ?? "لايوجد رقم",
        address: newAccount['address'] ?? "لايوجد عنوان",
        status: true,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );
      print("new costomer ${newAccount}");
      customerId = await customerController.createCusomer(newCustomer);
      CustomerAccount newCac = await addNewCustomerAccount(customerId);

      addJournal(newCac.id ?? 0);
      homeController.allHomeData.value =
          await homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
    } else {
      CustomerAccount? old =
          await customerAccountController.findCustomerAccountIfExist(
              cid: newAccount['customerId'],
              accg: newAccount['accGroupId'],
              curid: curencyController.selectedCurency['id']);

      if (old == null) {
        CustomerAccount newCac =
            await addNewCustomerAccount(newAccount['customerId']);
        addJournal(newCac.id ?? 0);
      } else {
        var currentCustomerAcccounter = old.copyWith(
            operation: old.operation + 1,
            totalCredit: old.totalCredit + newAccount['credit'],
            totalDebit: old.totalDebit + newAccount['debit']);
        customerAccountController
            .updateCustomerAccount(currentCustomerAcccounter);
        addJournal(old.id ?? 0);
      }
    }

    homeController.allHomeData.value =
        await homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
    accGroupCurencyController.getAllAccGroupAndCurency();
  }

  Future addJournal(int customerAccountId) async {
    var newJournal = Journal(
        customerAccountId: customerAccountId,
        details: newAccount['desc'],
        registeredAt: newAccount['date'],
        credit: newAccount['credit'],
        debit: newAccount['debit'],
        createdAt: newAccount['date'],
        modifiedAt: newAccount['date']);

    journalController.createJournal(newJournal);
  }

  Future<CustomerAccount> addNewCustomerAccount(int customerId) async {
    var newCustomerAccount = CustomerAccount(
      customerId: customerId,
      curencyId: curencyController.selectedCurency['id'],
      accgroupId: newAccount['accGroupId'],
      totalCredit: newAccount['credit'],
      totalDebit: newAccount['debit'],
      createdAt: DateTime.now(),
      operation: 1,
      status: true,
    );
    var currentCustomerAccount = await customerAccountController
        .createNewCusomerAccount(newCustomerAccount);
    homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
    print("new customerAccount : ${currentCustomerAccount}");

    return currentCustomerAccount;
  }

  Future<void> addNewJournalToCustomerAccount(CustomerAccount cac) async {
    print("it is exist and have custoemr account");
    var currentCustomerAcccounter = cac.copyWith(
        operation: cac.operation + 1,
        totalCredit: cac.totalCredit + newAccount['credit'],
        totalDebit: cac.totalDebit + newAccount['debit']);
    customerAccountController.updateCustomerAccount(currentCustomerAcccounter);
    addJournal(cac.id ?? 0);
  }

  Future<void> addNewRecordToCustomerAccount(HomeModel homeModel) async {
    var currentCustomerAccount = customerAccountController.allCustomerAccounts
        .firstWhere((element) =>
            element.id == homeModel.cacId &&
            element.curencyId == homeModel.curId &&
            element.customerId == homeModel.caId);
    addNewJournalToCustomerAccount(currentCustomerAccount);
    homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
  }
}
