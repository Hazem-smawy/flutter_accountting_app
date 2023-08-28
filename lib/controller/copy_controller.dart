import 'dart:io' as io;

import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/main_controller.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/http_service/google_drive_service.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:external_path/external_path.dart' as ex;

import 'accgroup_controller.dart';
import 'curency_controller.dart';
import 'customers_controller.dart';
import 'home_controller.dart';

class CopyController extends GetxController {
  AccGroupCurencyController accGroupCurencyController = Get.find();
  AccGroupController accGroupController = Get.find();
  CurencyController curencyController = Get.find();
  CustomerController customerController = Get.find();
  HomeController homeController = Get.find();

  // google drive
  final GoogleDriveAppData googleDriveAppData = GoogleDriveAppData();
  GoogleSignInAccount? googleUser;
  DriveApi? driveApi;
  DatabaseService databaseService = DatabaseService();

  Future<void> uploadCopy() async {
    if (driveApi == null) {
      await signIn();
    }
    if (driveApi != null) {
      CustomDialog.loadingProgress();
      String path = await databaseService.fullPath;

      await googleDriveAppData.uploadDriveFile(
        driveApi: driveApi!,
        file: io.File(path),
      );
      Get.back();
      CustomDialog.customSnackBar("تم حفظ النسخة بنجاح", SnackPosition.BOTTOM);
    }
  }

  Future<io.File?> getTheLastFile() async {
    if (driveApi == null) {
      await signIn();
    }

    if (driveApi != null) {
      try {
        CustomDialog.loadingProgress();

        List<File>? files =
            await googleDriveAppData.getAllDriveFiles(driveApi!);
        if (files != null) {
          File file = files.reduce((currentLatest, element) =>
              element.modifiedTime!.isAfter(currentLatest.modifiedTime!)
                  ? element
                  : currentLatest);

          String path = await databaseService.fullPath;

          io.File? result = await googleDriveAppData.restoreDriveFile(
              driveApi: driveApi!, driveFile: file, targetLocalPath: path);

          if (result != null) {
            Get.back();
            restoreSucess();
            return result;
          } else {
            Get.back();
            CustomDialog.customSnackBar(
                "لاتوجد ملفات في جوجل درايف", SnackPosition.TOP);
            return null;
          }
        } else {
          Get.back();
          CustomDialog.customSnackBar("حدث خطأ ", SnackPosition.TOP);
          return null;
        }
      } catch (e) {
        Get.back();
        CustomDialog.customSnackBar("حدث خطأ ", SnackPosition.TOP);
        return null;
      }
    }
  }

  Future<void> getSlelectedCopy(File file) async {
    CustomDialog.loadingProgress();
    try {
      String path = await databaseService.fullPath;

      await googleDriveAppData.restoreDriveFile(
          driveApi: driveApi!, driveFile: file, targetLocalPath: path);

      Get.back();
      restoreSucess();
      return;
    } catch (e) {
      Get.back();
      CustomDialog.customSnackBar("حدث خطأ ", SnackPosition.TOP);
      return;
    }
  }

  void restoreSucess() async {
    await customerController.readAllCustomer();
    await curencyController.readAllCurency();
    await accGroupController.readAllAccGroup();
    await accGroupCurencyController.getAllAccGroupAndCurency();
    await homeController.getCustomerAccountsFromCurencyAndAccGroupIds();

    Get.back();
    CustomDialog.customSnackBar(
        "تم إسترجاع النسخة بنجاح", SnackPosition.BOTTOM);
  }

  Future<List<File>?> getAllFiles() async {
    if (driveApi == null) {
      await signIn();
    }
    if (driveApi != null) {
      List<File>? allfiles =
          await googleDriveAppData.getAllDriveFiles(driveApi!);
      return allfiles;
    } else {
      CustomDialog.customSnackBar("error restore all files", SnackPosition.TOP);
      return null;
    }
  }

  Future<void> signIn() async {
    if (googleUser == null) {
      googleUser = await googleDriveAppData.signInGoogle();

      if (googleUser != null) {
        driveApi = await googleDriveAppData.getDriveApi(googleUser!);
      } else {
        CustomDialog.customSnackBar(
            "حدث خطأ أثناء تسجيل الدخول", SnackPosition.TOP);
        return;
      }
    } else {
      driveApi = await googleDriveAppData.getDriveApi(googleUser!);
    }
    update();
  }

  Future<void> deleteDriveFile(File file) async {
    await googleDriveAppData.deleteDriveFile(
        driveApi: driveApi!, driveFile: file);
  }

  Future<void> signOut() async {
    await googleDriveAppData.signOut();
    googleUser = null;
    driveApi = null;
    update();
  }

  // folders
  Future<void> selectFolder() async {
    CustomDialog.loadingProgress();
    try {
      String path = await ex.ExternalPath.getExternalStoragePublicDirectory(
          ex.ExternalPath.DIRECTORY_DOWNLOADS);
      final file = await io.File(
              '$path/account_app${DateTime.now().millisecondsSinceEpoch}.db')
          .create(recursive: true);

      copyDatabaseToFolder(file.path).then((value) {
        Get.back();
        CustomDialog.customSnackBar(
            "تم الحفظ بنجاح في ${file.path}", SnackPosition.BOTTOM);
      });
      //  }
    } catch (e) {
      print("error open filepicker : $e");
    }
  }

  Future<void> copyDatabaseToFolder(String selectedFolderPath) async {
    String path = await databaseService.fullPath;
    if (await io.File(path).exists()) {
      final bytes = await io.File(path).readAsBytes();

      String targetPath = selectedFolderPath;
      io.File targetDatabase = io.File(targetPath);

      await targetDatabase.writeAsBytes(bytes);
    }
  }

  Future<io.File?> copyDatabaseFromFolder(String selectedFolderPath) async {
    final res = selectedFolderPath.split('.');
    if (res.last == 'db') {
      String path = await databaseService.fullPath;

      await deleteDatabase(path);
      io.File(path).openWrite();
      io.File file = await io.File(selectedFolderPath).copy(path);

      return file;
    } else {
      return null;
    }
  }

  Future<bool> openDatabaseFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        CustomDialog.loadingProgress();
        PlatformFile file = result.files.first;
        if (file.path != null) {
          io.File? res = await copyDatabaseFromFolder(file.path!);

          if (res != null) {
            Get.back();
            restoreSucess();
            return true;
          } else {
            Get.back();
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // ios

  Future<void> copyDatabaseToFolderIos(String selectedFolderPath) async {
    String databasePath = await databaseService.fullPath;

    if (await io.File(databasePath).exists()) {
      final bytes = await io.File(databasePath).readAsBytes();
      String targetPath = p.join(selectedFolderPath,
          'account_app_copy_${DateTime.now().toIso8601String()}.db');
      io.File targetDatabase = io.File(targetPath);

      await targetDatabase.writeAsBytes(bytes);
    }
  }

  Future<void> selectFolderIos() async {
    try {
      String? result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        CustomDialog.loadingProgress();
        await copyDatabaseToFolderIos(result);
        Get.back();
        CustomDialog.customSnackBar(
            "تم حفظ النسخة بنجاح", SnackPosition.BOTTOM);
      }
    } catch (e) {}
  }
}
