import 'dart:io';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class FolderCopyWidget extends StatefulWidget {
  const FolderCopyWidget({super.key});

  @override
  State<FolderCopyWidget> createState() => _FolderCopyWidgetState();
}

class _FolderCopyWidgetState extends State<FolderCopyWidget> {
  AccGroupCurencyController accGroupCurencyController = Get.find();
  Future<void> copyDatabaseToFolder(String selectedFolderPath) async {
    Directory path = await getApplicationDocumentsDirectory();
    String databasePath = p.join(path.path, "account_app_database.db");

    if (await File(databasePath).exists()) {
      final bytes = await File(databasePath).readAsBytes();
      String targetPath = p.join(selectedFolderPath, 'account_app_copy.db');
      File targetDatabase = File(targetPath);

      try {
        // await sourceDatabase.copy(targetPath);
        targetDatabase.writeAsBytes(bytes);
        print("Database copied to $selectedFolderPath");
      } catch (e) {
        print("Error copying database: $e");
      }
    }
  }

  String _selectedFolderPath = '';

  Future<void> _selectFolder() async {
    try {
      // String? path = await FilesystemPicker.open(
      //   title: 'Save to folder',
      //   context: this.context,
      //   rootDirectory: Directory("/"),
      //   fsType: FilesystemType.folder,
      //   pickText: 'Save file to this folder',
      // );
      // print(path);
      String? result = await FilePicker.platform.getDirectoryPath();
      if (result != null) {
        setState(() {
          _selectedFolderPath = result;
          copyDatabaseToFolder(_selectedFolderPath);
        });
      }
    } catch (e) {
      print("error open filepicker : $e");
    }
  }

  Future<void> copyDatabaseFromFolder(String selectedFolderPath) async {
    Directory path = await getApplicationDocumentsDirectory();
    String databasePath = p.join(path.path, "account_database1.db");

    // await File(databasePath).delete();

    await deleteDatabase(databasePath);
    //await DatabaseService.instance.database.obs;

    await File(databasePath).openWrite();
    File(selectedFolderPath).copy(databasePath);

    CustomDialog.showDialog(
        title: "تنبة",
        description: "سيتم إغلاق التطبيق قم بإعادة فتحة",
        icon: FontAwesomeIcons.circleInfo,
        color: Colors.red,
        action: () {});
    await Future.delayed(const Duration(seconds: 2));

    exit(0);
  }

  Future<void> _openDatabaseFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.path != null) {
          _selectedFolderPath = file.path!;
          copyDatabaseFromFolder(_selectedFolderPath);
        }
      } else {
        // User canceled the picker
      }
    } catch (e) {
      Get.log("hello");
    }
  }

  Future<Database> openDatabaseFormFile(String filePath) async {
    return openDatabase(filePath, version: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  const FaIcon(FontAwesomeIcons.folderClosed),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "النسخ الإحتياطي للملفات",
                    style: myTextStyles.title2,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCopyBtnWidget(
              color: Colors.green,
              icon: FontAwesomeIcons.download,
              label: "عمل نسخة جد يد ة",
              action: () => _selectFolder(),
              description:
                  "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
            ),
            CustomCopyBtnWidget(
              color: const Color.fromARGB(197, 149, 7, 7),
              icon: FontAwesomeIcons.upload,
              label: "فتح نسخة سابقة",
              //  action: () {},
              action: () => _openDatabaseFile(),
              description:
                  "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ));
  }
}
