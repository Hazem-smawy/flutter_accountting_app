import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/service/customer_account_data.dart';
import 'package:get/get.dart';

class CustomerAccountController extends GetxController {
  CustomerAccountData customerAccountData = CustomerAccountData();
  AccGroupController accGroupController = AccGroupController();
  final customerAccountSearchTextField = "".obs;
  final allCustomerAccounts = <CustomerAccount>[].obs;
  final newCustomerAccount = {}.obs;
  final searchedList = <CustomerAccount>[].obs;

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
    allCustomerAccounts.forEach((e) {
      deleteCustomerAccount(e.id ?? 0);
    });
  }

  Future<void> readAllCustomerAccounts() async {
    allCustomerAccounts.value =
        await customerAccountData.readAllCustomerAccounts();
    searchedList.value = allCustomerAccounts;
    // acFike();
  }

  Future<CustomerAccount> createNewCusomerAccount(
      CustomerAccount customerAccount) async {
    var newCustomerAccount = await customerAccountData.create(customerAccount);

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
