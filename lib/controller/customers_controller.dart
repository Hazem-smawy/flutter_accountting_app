
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/customer_data.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  CustomerData customerData = CustomerData();
  final allCustomers = <Customer>[].obs;
  final newCustomer = {}.obs;

  /*
  _productsController.newProduct.update(
        'status', (value) => value,
        ifAbsent: (() => value));
  }

 */
  @override
  void onInit() {
    readAllCustomer();
    super.onInit();
  }

  Future<void> readAllCustomer() async {
    allCustomers.value = await customerData.readAllCustomers();
  }

  Future<void> createCusomer(Customer customer) async {
    customerData.create(customer);
    readAllCustomer();
  }

  Future<void> updateCustomer(Customer customer) async {
  
    customerData.updateCustomer(customer);
    readAllCustomer();
  }

  Future<void> deleteCustomer(int id) async {
    customerData.delete(id);
    readAllCustomer();
  }
}
