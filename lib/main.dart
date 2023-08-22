import 'package:account_app/constant/colors.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/controller/customer_account_controller.dart';
import 'package:account_app/controller/customers_controller.dart';
import 'package:account_app/controller/home_controller.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/controller/journal_controller.dart';
import 'package:account_app/controller/new_account_controller.dart';
import 'package:account_app/controller/pdf_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/screen/intro_screen/intro_screen.dart';
import 'package:account_app/screen/main_screen/main_screen.dart';
import 'package:account_app/service/http_service/google_drive_service.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/empty_accGroup_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'firebase_options.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  IntroController introController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: MyColors.containerColor,
      ),
      // theme: AppThemes.darkTheme,
      // home: MyHomePage(),
      home: Obx(
        () => introController.introShow.value
            ? ShowMyMainScreen()
            : const MyEntroScreen(),
      ),
    );
  }
}

class ShowMyMainScreen extends StatelessWidget {
  ShowMyMainScreen({super.key});
  AccGroupController accGroupController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => accGroupController.allAccGroups.isEmpty
          ? const Scaffold(
              backgroundColor: MyColors.bg,
              body: EmptyAccGroupsWidget(),
            )
          : MyMainScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final GoogleDriveAppData _googleDriveAppData = GoogleDriveAppData();
//   GoogleSignInAccount? _googleUser;
//   DriveApi? _driveApi;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               child: Text("sign in"),
//               onPressed: () async {
//                 if (_googleUser == null) {
//                   _googleUser = await _googleDriveAppData.signInGoogle();
//                   if (_googleUser != null) {
//                     _driveApi =
//                         await _googleDriveAppData.getDriveApi(_googleUser!);
//                   }
//                 } else {
//                   await _googleDriveAppData.signOut();
//                   _googleUser = null;
//                   _driveApi = null;
//                 }
//                 setState(() {});
//               },
//             ),
//             ElevatedButton(
//               onPressed: _driveApi != null
//                   ? () {
//                       FilePicker.platform.pickFiles().then((value) {
//                         if (value != null && value.files[0] != null) {
//                           io.File selectedFile = io.File(value.files[0].path!);
//                           _googleDriveAppData.uploadDriveFile(
//                             driveApi: _driveApi!,
//                             file: selectedFile,
//                           );
//                         }
//                       });
//                     }
//                   : null,
//               child: Text('Save sth to drive'),
//             ),
//             ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     File? file = await _googleDriveAppData.getDriveFile(
//                         _driveApi!, "account_app_copy.db");

//                     if (file != null) {
//                       Get.log("file is :$file");
//                       io.Directory path =
//                           await getApplicationDocumentsDirectory();
//                       String databasePath =
//                           p.join(path.path, "account_app_database.db");

//                       await _googleDriveAppData
//                           .restoreDriveFile(
//                               driveApi: _driveApi!,
//                               driveFile: file,
//                               targetLocalPath: databasePath)
//                           .then((value) {
//                         print("it is complete");
//                       });
//                     } else {
//                       Get.log("file is :$file");
//                     }
//                   } catch (e) {
//                     print(e);
//                   }
//                 },
//                 child: Text("get file"))
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> copyDatabaseFromFolder(io.File selectedFolderPath) async {
//     io.Directory path = await getApplicationDocumentsDirectory();
//     String databasePath = p.join(path.path, "account_database1.db");

//     // await File(databasePath).delete();

//     await deleteDatabase(databasePath);
//     //await DatabaseService.instance.database.obs;

//     await io.File(databasePath).openWrite();
//     selectedFolderPath.copy(databasePath);

//     CustomDialog.showDialog(
//         title: "تنبة",
//         description: "سيتم إغلاق التطبيق قم بإعادة فتحة",
//         icon: FontAwesomeIcons.circleInfo,
//         color: Colors.red,
//         action: () {});
//     await Future.delayed(const Duration(seconds: 2));
//   }
// }
