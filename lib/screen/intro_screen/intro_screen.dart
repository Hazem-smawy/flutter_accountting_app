import 'dart:io';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/main.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

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
      "desc":
          "الله في الإسلام هو الإله الواحد الأحد وهو وصف لغوي للذات الإلهية. وله أسماء تسمى أسماء الله الحسنى وهي أكثر من أن تعد"
    },
  ];
  int i = 0;
  String _selectedFolderPath = '';
  final controller = PageController();
  IntroController introController = Get.find();

  Future<void> copyDatabaseFromFolder(String selectedFolderPath) async {
    Directory path = await getApplicationDocumentsDirectory();
    String databasePath = join(path.path, "account_database1.db");

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
      print("Error open db :$e");
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
                          page: pages[index],
                        ),
                        const Spacer(),
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
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // introController.updateIntro();
                                  _openDatabaseFile();
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
                                      border: Border.all(
                                        color: MyColors.bg,
                                      )),
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
                                        "استعادة نسخة ",
                                        style: myTextStyles.title2.copyWith(
                                          color: MyColors.bg,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 50,
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
  const FirstPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          SizedBox(
            height: Get.height / 8,
          ),
          Image.asset(
            page['image'],
            width: Get.width - 150,
          ),
          SizedBox(
            height: Get.height / 7,
          ),
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
