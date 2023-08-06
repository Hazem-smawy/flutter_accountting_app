import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/models/home_model.dart';

import 'package:account_app/models/journal_model.dart';
import 'package:get/get.dart';

class NewAccountController extends GetxController {
  var newAccount = {}.obs;
  CustomerController customerController = Get.find();
  JournalController journalController = Get.find();
  CurencyController curencyController = Get.find();
  CustomerAccountController customerAccountController = Get.find();
  HomeController homeController = HomeController();
  Future<void> createNewCustomerAccount() async {
    print(newAccount);
    print(curencyController.selectedCurency);

    final int? customerId;
    if (newAccount['new'] != null) {
      var newCustomer = Customer(
        name: newAccount['name'],
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
              curid: curencyController.selectedCurency['crId'] ??
                  curencyController.selectedCurency['id']);

      if (old == null) {
        print("it is exist put have not customerAccount");
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
      curencyId: curencyController.selectedCurency['crId'] ??
          curencyController.selectedCurency['id'],
      accgroupId: newAccount['accGroupId'],
      totalCredit: newAccount['credit'],
      totalDebit: newAccount['debit'],
      createdAt: DateTime.now(),
      operation: 1,
    );
    var currentCustomerAccount = await customerAccountController
        .createNewCusomerAccount(newCustomerAccount);
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
