import 'package:account_app/service/intro_data.dart';
import 'package:get/get.dart';

class IntroController extends GetxController {
  final introShow = false.obs;
  IntroData introData = IntroData();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    createIntro();
    readIntro();
  }

  Future<void> createIntro() async {
    await introData.create();
  }

  Future<void> readIntro() async {
    introShow.value = await introData.read();
  }

  Future<void> updateIntro() async {
    await introData.update();
  }
}
