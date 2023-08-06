import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/customer_account_data.dart';
import 'package:get/get.dart';
import 'package:account_app/models/customer_account.dart';

class CustomerAccountController extends GetxController {
  CustomerAccountData customerAccountData = CustomerAccountData();
  AccGroupController accGroupController = AccGroupController();

  final allCustomerAccounts = <CustomerAccount>[].obs;
  final newCustomerAccount = {}.obs;

  /*
  _productsController.newProduct.update(
        'status', (value) => value,
        ifAbsent: (() => value));
  }

 */
  @override
  void onInit() {
    readAllCustomerAccounts();

    super.onInit();
  }

  Future<void> acFike() async {
    final list = [
      CustomerAccount(
          customerId: 214,
          curencyId: 5718,
          accgroupId: 7353,
          totalCredit: 200,
          totalDebit: 0,
          operation: 4,
          createdAt: DateTime.now()),
      CustomerAccount(
          customerId: 214,
          curencyId: 5718,
          accgroupId: 7353,
          totalCredit: 200,
          totalDebit: 0,
          operation: 4,
          createdAt: DateTime.now()),
      // CustomerAccount(
      //     customerId: 214,
      //     curencyId: 7014,
      //     accgroupId: 4684,
      //     totalCredit: 200,
      //     totalDebit: 0,
      //     operation: 4,
      //     createdAt: DateTime.now()),
      // CustomerAccount(
      //     customerId: 588,
      //     curencyId: 5718,
      //     accgroupId: 4267,
      //     totalCredit: 200,
      //     totalDebit: 0,
      //     operation: 4,
      //     createdAt: DateTime.now()),
    ];
    print(allCustomerAccounts);
    // allCustomerAccounts.forEach((element) {
    //   deleteCustomerAccount(element.id ?? 0);
    // });

    deleteCustomerAccount(1);
  }

  Future<void> readAllCustomerAccounts() async {
    allCustomerAccounts.value =
        await customerAccountData.readAllCustomerAccounts();
  }

  Future<CustomerAccount> createNewCusomerAccount(
      CustomerAccount customerAccount) async {
    var newCustomerAccount = customerAccountData.create(customerAccount);
    // readAllCustomerAccounts();
    readAllCustomerAccounts();
    return newCustomerAccount;
  }

  Future<CustomerAccount?> findCustomerAccountIfExist(
      {required int cid, required int accg, required int curid}) async {
    return customerAccountData.isCustomerAccountExist(
        customerId: cid, accGroupId: accg, curencyId: curid);
  }

  Future<void> updateCustomerAccount(CustomerAccount customerAccount) async {
    customerAccountData.updateCustomerAccount(customerAccount);
    readAllCustomerAccounts();
  }

  Future<void> deleteCustomerAccount(int id) async {
    customerAccountData.delete(id);
    readAllCustomerAccounts();
  }
}
