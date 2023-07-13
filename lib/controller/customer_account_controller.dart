import 'package:account_app/models/customer_account.dart';
import 'package:account_app/service/customer_account_data.dart';
import 'package:get/get.dart';

class CustomerAccountController extends GetxController {
  CustomerAccountData customerAccountData = CustomerAccountData();
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

  Future<void> readAllCustomerAccounts() async {
    allCustomerAccounts.value =
        await customerAccountData.readAllCustomerAccounts();
  }

  Future<void> createCusomer(CustomerAccount customerAccount) async {
    customerAccountData.create(customerAccount);
    readAllCustomerAccounts();
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
