import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/service/accgroup_data.dart';
import 'package:get/get.dart';

class AccGroupController extends GetxController {
  AccGroupData accGroupData = AccGroupData();
  final allAccGroups = <AccGroup>[].obs;
  final newAccGroup = {}.obs;

  /*
  _productsController.newProduct.update(
        'status', (value) => value,
        ifAbsent: (() => value));
  }

 */
  @override
  void onInit() {
    readAllAccGroup();
    super.onInit();
  }

  Future<void> readAllAccGroup() async {
    allAccGroups.value = await accGroupData.readAllAccGroups();
  }

  Future<void> createAccGroup(AccGroup accGroup) async {
    accGroupData.create(accGroup);
    readAllAccGroup();
  }

  Future<void> updateAccGroup(AccGroup accGroup) async {
    accGroupData.updateAccGroup(accGroup);
    readAllAccGroup();
  }

  Future<void> deleteAccGroup(int id) async {
    accGroupData.delete(id);
    readAllAccGroup();
  }
}
