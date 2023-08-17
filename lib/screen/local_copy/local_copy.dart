import 'dart:io';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalCopyScreen extends StatefulWidget {
  const LocalCopyScreen({super.key});

  @override
  State<LocalCopyScreen> createState() => _LocalCopyScreenState();
}

class _LocalCopyScreenState extends State<LocalCopyScreen> {
  AccGroupCurencyController accGroupCurencyController = Get.find();
  CustomerController customerController = Get.find();
  AccGroupController accGroupController = Get.find();
  CurencyController curencyController = Get.find();
  JournalController journalController = Get.find();
  CustomerAccountController customerAccountController = Get.find();

  HomeController homeController = Get.find();
  NewAccountController newAccountController = Get.find();
  IntroController introController = Get.find();
  PersonalController personalController = Get.find();
  Future<void> copyDatabaseToFolder(String selectedFolderPath) async {
    Directory path = await getApplicationDocumentsDirectory();
    String databasePath = join(path.path, "account_databse.db");

    if (await File(databasePath).exists()) {
      File sourceDatabase = File(databasePath);
      String targetPath = join(selectedFolderPath, 'account_app_copy.db');
      File targetDatabase = File(targetPath);

      try {
        await sourceDatabase.copy(targetPath);
        print("Database copied to $selectedFolderPath");
      } catch (e) {
        print("Error copying database: $e");
      }
    }
  }

  String _selectedFolderPath = '';

  Future<void> _selectFolder() async {
    try {
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
    String databasePath = join(path.path, "account_databse.db");

    if (await File(selectedFolderPath).exists()) {
      File currentDatabase = File(databasePath);
      String oldDatabasePath = selectedFolderPath;
      File oldDatabase = File(oldDatabasePath);

      try {
        // var db = await DatabaseService.instance.database;
        // db.close();
        await currentDatabase.delete();
        await oldDatabase.copy(currentDatabase.path);

        await oldDatabase.rename(databasePath);
        //await openDatabaseFormFile(oldDatabasePath);
        await DatabaseService.instance.database;

        await curencyController.readAllCurency();
        await accGroupController.readAllAccGroup();
        await customerController.readAllCustomer();

        await customerAccountController.readAllCustomerAccounts();
        await accGroupCurencyController.getAllAccGroupAndCurency();
        CustomDialog.showDialog(
          title: "تنبة",
          description: "سيتم إغلاق التطبيق قم بإعادة فتحة",
          icon: FontAwesomeIcons.circleInfo,
          color: Colors.red,
        );
        await Future.delayed(const Duration(seconds: 2));
        exit(0);
      } catch (e) {
        print("Error copying database: $e");
      }
    }
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
      print("Error open db :$e");
    }
  }

  Future<Database> openDatabaseFormFile(String filePath) async {
    return openDatabase(filePath, version: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const CustomBackBtnWidget(title: " النسخ الإ حتياطي"),
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
              const SizedBox(
                height: 20,
              ),
              CustomCopyBtnWidget(
                color: const Color.fromARGB(197, 149, 7, 7),
                icon: FontAwesomeIcons.upload,
                label: "فتح نسخة سابقة",
                action: () => _openDatabaseFile(),
                description:
                    "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCopyBtnWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final description;
  VoidCallback action;
  CustomCopyBtnWidget(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.description,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.bg,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 10,
            ),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: myTextStyles.subTitle,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              action();
            },
            child: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: myTextStyles.title2.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FaIcon(
                    icon,
                    size: 17,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
