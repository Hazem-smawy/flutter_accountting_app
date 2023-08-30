import 'dart:async';

import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/models/sitting_model.dart';
import 'package:account_app/service/database/sitting_data.dart';
import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';

class SittingController extends GetxController {
  final every = 0.obs;
  final everyArray = [1, 2, 7, 30];
  final toggleAsyncGoogleDrive = false.obs;
  CopyController copyController = Get.find();
  SittingData sittingData = SittingData();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    readSitting();
  }

  Future<void> createSitting() async {
    var sittingModel = SittingModel(id: 1, every: 0, isCopyOn: false);

    await sittingData.create(sittingModel);
  }

  Future<void> readSitting() async {
    var res = await sittingData.read(1);
    if (res == null) {
      createSitting();
    } else {
      every.value = res.every;
      toggleAsyncGoogleDrive.value = res.isCopyOn;
    }
  }

  Future<void> updateSitting(bool isCopyOn, int every) async {
    var sittingModel = SittingModel(id: 1, every: every, isCopyOn: isCopyOn);

    await sittingData.update(sittingModel);
  }

  Future<void> deleteSitting() async {
    await sittingData.delete(1);
  }

  Future<void> toogleIsCopyOn(bool isOn) async {
    toggleAsyncGoogleDrive.value = isOn;
    await updateSitting(toggleAsyncGoogleDrive.value, every.value);
    if (isOn) {
      setCopyToGoogleDriveEvery();
    } else {
      Workmanager().cancelAll();
    }
  }

  Future<void> increemint() async {
    if (every < everyArray.length) {
      every.value++;
      await updateSitting(toggleAsyncGoogleDrive.value, every.value);
      Workmanager().cancelAll();
      setCopyToGoogleDriveEvery();
    }
  }

  Future<void> decreemint() async {
    if (every > -1) {
      every.value--;
      await updateSitting(toggleAsyncGoogleDrive.value, every.value);
      Workmanager().cancelAll();
      setCopyToGoogleDriveEvery();
    }
  }

  void setCopyToGoogleDriveEvery() {
    Workmanager().registerPeriodicTask("threeTask", 'backUp',
        frequency: Duration(hours: 24 * every.value),
        constraints: Constraints(networkType: NetworkType.connected));
  }
}
