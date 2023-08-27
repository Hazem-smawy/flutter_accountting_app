import 'package:get/get.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/controller/pdf_controller.dart';
import 'package:account_app/controller/personal_controller.dart';

class MainController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    intializedApp();
  }

  Future<void> intializedApp() async {
    Get.put(AccGroupCurencyController());
    Get.put(CustomerController());
    Get.put(AccGroupController());
    Get.put(CurencyController());
    Get.put(JournalController());
    Get.put(CustomerAccountController());
    Get.put(HomeController());
    Get.put(NewAccountController());
    Get.put(IntroController());
    Get.put(PersonalController());
    Get.put(PdfApi());
    Get.put(CopyController());
  }

  Future<void> updateAll() async {
    AccGroupCurencyController accGroupCurencyController = Get.find();
    AccGroupController accGroupController = Get.find();
    CurencyController curencyController = Get.find();
    CustomerController customerController = Get.find();
    HomeController homeController = Get.find();

    await customerController.readAllCustomer();
    await curencyController.readAllCurency();
    await accGroupController.readAllAccGroup();
    await homeController.getCustomerAccountsFromCurencyAndAccGroupIds();
    await accGroupCurencyController.getAllAccGroupAndCurency();
  }
}
