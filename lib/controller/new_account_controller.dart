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
  CustomerController customerController = CustomerController();
  JournalController journalController = JournalController();
  CustomerAccountController customerAccountController =
      CustomerAccountController();
  HomeController homeController = HomeController();
  Future<void> createNewCustomerAccount() async {
    print(newAccount);
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
              cid: int.parse(newAccount['customerId']),
              accg: int.parse(newAccount['accGroupId']),
              curid: int.parse(newAccount['curencyId']));

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
        curencyId: newAccount['curencyId'],
        accgroupId: newAccount['accGroupId'],
        totalCredit: newAccount['credit'],
        totalDebit: newAccount['debit'],
        createdAt: DateTime.now(),
        operation: 1);
    var currentCustomerAccount = await customerAccountController
        .createNewCusomerAccount(newCustomerAccount);

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
}