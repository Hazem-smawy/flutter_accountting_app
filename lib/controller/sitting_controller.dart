import 'dart:async';

import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/models/sitting_model.dart';
import 'package:account_app/service/database/sitting_data.dart';
import 'package:get/get.dart';

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
    //setCopyToGoogleDriveEvery();
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
  }

  Future<void> increemint() async {
    if (every < everyArray.length) {
      every.value++;
      await updateSitting(toggleAsyncGoogleDrive.value, every.value);
    }
  }

  Future<void> decreemint() async {
    if (every > -1) {
      every.value--;
      await updateSitting(toggleAsyncGoogleDrive.value, every.value);
    }
  }

  // void setCopyToGoogleDriveEvery() {
  //   Duration copyEveryDuration = Duration(hours: 24 * everyArray[every.value]);
  //   // Duration copyEveryDuration = Duration(minutes: 5);

  //   Timer.periodic(copyEveryDuration, (timer) async {
  //     if (toggleAsyncGoogleDrive.value) {
  //       await copyController.uploadCopy();
  //       print("hello copy");
  //     }
  //   });
  // }
}
