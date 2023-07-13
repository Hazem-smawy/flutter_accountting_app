import 'package:account_app/models/curency_model.dart';
import 'package:account_app/service/curency_data.dart';
import 'package:get/get.dart';

class CurencyController extends GetxController {
  CurencyData curencyData = CurencyData();
  final allCurency = <Curency>[].obs;
  final newCurency = {}.obs;
  final editCurency = {}.obs;

  /*
  _productsController.newProduct.update(
        'status', (value) => value,
        ifAbsent: (() => value));
  }

 */
  @override
  void onInit() {
    readAllCurency();
    super.onInit();
  }

  Future<void> readAllCurency() async {
    allCurency.value = await curencyData.readAllCurencies();
  }

  Future<void> createCurency(Curency curency) async {
    curencyData.create(curency);
    readAllCurency();
  }

  Future<void> updateCurency(Curency curency) async {
    curencyData.updateCurency(curency);
    readAllCurency();
  }

  Future<void> deleteCurency(int id) async {
    curencyData.delete(id);
    readAllCurency();
  }
}
