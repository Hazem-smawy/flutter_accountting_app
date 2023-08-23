import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/main.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:account_app/service/http_service/google_drive_service.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

class MyEntroScreen extends StatefulWidget {
  const MyEntroScreen({super.key});

  @override
  State<MyEntroScreen> createState() => _MyEntroScreenState();
}

class _MyEntroScreenState extends State<MyEntroScreen> {
  List pages = [
    {
      "id": 2,
      "image": "assets/images/curency1.png",
      "title": "العنوان",
      "desc":
          "الله في الإسلام هو الإله الواحد الأحد وهو وصف لغوي للذات الإلهية. وله أسماء تسمى أسماء الله الحسنى وهي أكثر من أن تعد"
    },
    {
      "id": 1,
      "image": "assets/images/customerAccount1.png",
      "title": "العنوان",
      "desc":
          "الله في الإسلام هو الإله الواحد الأحد وهو وصف لغوي للذات الإلهية. وله أسماء تسمى أسماء الله الحسنى وهي أكثر من أن تعد"
    },
    {
      "id": 0,
      "image": "assets/images/customerAccount.png",
      "title": "العنوان",
      "desc": ". أكثر من أن تعد إغلاق التطبيق"
    },
  ];
  int i = 0;
  String _selectedFolderPath = '';
  final controller = PageController();
  IntroController introController = Get.find();

  //drive
  final GoogleDriveAppData _googleDriveAppData = GoogleDriveAppData();

  GoogleSignInAccount? _googleUser;

  DriveApi? _driveApi;

  Future<void> copyDatabaseFromFolder(String selectedFolderPath) async {
    io.Directory path = await getApplicationDocumentsDirectory();
    String databasePath = p.join(path.path, "account_database1.db");

    // await File(databasePath).delete();

    await deleteDatabase(databasePath);
    //await DatabaseService.instance.database.obs;

    await io.File(databasePath).openWrite();
    io.File(selectedFolderPath).copy(databasePath);

    CustomDialog.showDialog(
        title: "تنبة",
        description: "سيتم إغلاق التطبيق قم بإعادة فتحة",
        icon: FontAwesomeIcons.circleInfo,
        color: Colors.red,
        action: () {});
    await Future.delayed(const Duration(seconds: 2));

    io.exit(0);
  }

  Future<void> _openDatabaseFile() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lessBlackColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  reverse: true,
                  onPageChanged: (value) {
                    setState(() {
                      i = value;
                    });
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        if (index == pages.length - 1)
                          Row(
                            children: [
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.previousPage(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.bounceInOut);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 20,
                                      top: 10,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "رجوع",
                                          style: myTextStyles.subTitle,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const FaIcon(
                                          FontAwesomeIcons.arrowRightLong,
                                          color: MyColors.secondaryTextColor,
                                          size: 15,
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        FirstPage(
                          lastPage: pages.length - 1 == index,
                          page: pages[index],
                        ),
                        const Spacer(),

                        //TODO: download copy btns
                        if (index == pages.length - 1)
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  introController.updateIntro();
                                  Get.to(() => ShowMyMainScreen());
                                },
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        const Color.fromARGB(255, 64, 203, 143)
                                            .withOpacity(0.7),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.arrowLeftLong,
                                        size: 18,
                                        color: MyColors.containerColor,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "الصفحة الرئيسية",
                                        style: myTextStyles.title2.copyWith(
                                          color: MyColors.bg,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      try {
                                        _googleUser = await _googleDriveAppData
                                            .signInGoogle();

                                        if (_googleUser == null) {
                                          return;
                                        }

                                        print("${_googleUser?.authHeaders} ");
                                        if (_googleUser != null) {
                                          _driveApi = await _googleDriveAppData
                                              .getDriveApi(_googleUser!);
                                        }

                                        setState(() {});
                                        CustomDialog.loadingProgress();

                                        File? file = await _googleDriveAppData
                                            .getDriveFile(_driveApi!,
                                                "account_app_copy.db");

                                        if (file != null) {
                                          Get.log("file is :$file");
                                          io.Directory path =
                                              await getApplicationDocumentsDirectory();
                                          String databasePath = p.join(
                                              path.path,
                                              "private_account_app_database.db");

                                          await _googleDriveAppData
                                              .restoreDriveFile(
                                                  driveApi: _driveApi!,
                                                  driveFile: file,
                                                  targetLocalPath: databasePath)
                                              .then((value) {});
                                          print(file);
                                        } else {
                                          Get.log("file is :$file");
                                        }
                                      } catch (e) {
                                        Get.back();
                                        CustomDialog.customSnackBar(
                                            "حدث خطأ ", SnackPosition.TOP);
                                        return;
                                      }
                                      Get.back();
                                      CustomDialog.customSnackBar(
                                          "تم إسترجاع النسخة بنجاح",
                                          SnackPosition.TOP);

                                      CustomDialog.showDialog(
                                          title: "تنبة",
                                          description:
                                              "سيتم إغلاق التطبيق قم بإعادة فتحة",
                                          icon: FontAwesomeIcons.circleInfo,
                                          color: Colors.red,
                                          action: () {});
                                      await Future.delayed(
                                          const Duration(seconds: 2));

                                      io.exit(0);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: MyColors.secondaryTextColor,
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.googleDrive,
                                            size: 15,
                                            color: MyColors.containerColor,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // introController.updateIntro();
                                      _openDatabaseFile();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                            color: MyColors.secondaryTextColor,
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          SizedBox(
                                            width: 15,
                                          ),
                                          FaIcon(
                                            FontAwesomeIcons.solidFolderClosed,
                                            size: 15,
                                            color: MyColors.containerColor,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  }),
            ),
            if (i != pages.length - 1)
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: MyColors.secondaryTextColor),
                            shape: BoxShape.circle),
                        child: const FaIcon(
                          FontAwesomeIcons.chevronRight,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: pages
                              .map(
                                (e) => AnimatedContainer(
                                  duration: const Duration(microseconds: 200),
                                  margin: const EdgeInsets.only(left: 5),
                                  width: e['id'] == i ? 15 : 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: e['id'] == i
                                        ? const Color.fromARGB(
                                            255, 88, 223, 162)
                                        : Colors.white,
                                  ),
                                ),
                              )
                              .toList()),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: MyColors.secondaryTextColor),
                            shape: BoxShape.circle),
                        child: const FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  final page;
  FirstPage({super.key, required this.page, required this.lastPage});
  bool lastPage;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          SizedBox(
            height: Get.height / 8,
          ),
          //if (lastPage)
          Image.asset(
            page['image'],
            width: lastPage ? Get.width / 2 - 50 : Get.width - 150,
            //  height: lastPage ? Get.width / 5 : null,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Get.height / 9,
          ),
          // if (!lastPage)
          Text(
            page['title'],
            style: myTextStyles.title2.copyWith(
              color: MyColors.containerColor,
              fontWeight: FontWeight.normal,
              fontSize: 23,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //  if (!lastPage)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              page['desc'],
              textAlign: TextAlign.center,
              style: myTextStyles.body.copyWith(
                color: MyColors.containerSecondColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
