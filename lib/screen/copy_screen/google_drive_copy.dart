import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/service/http_service/google_drive_service.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/forms/v1.dart';
import 'package:intl/intl.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

import 'package:path_provider/path_provider.dart';

class GoogleDriveCopyWidget extends StatefulWidget {
  GoogleDriveCopyWidget({super.key});

  @override
  State<GoogleDriveCopyWidget> createState() => _GoogleDriveCopyWidgetState();
}

class _GoogleDriveCopyWidgetState extends State<GoogleDriveCopyWidget> {
  final GoogleDriveAppData _googleDriveAppData = GoogleDriveAppData();
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _googleUser;

  DriveApi? _driveApi;
  String? accessToken;

  @override
  void initState() {
    super.initState();
    _googleDriveAppData.signInGoogle().then((value) {
      setState(() {
        _googleUser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //  padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.bg,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
            child: Column(
              children: [
                const FaIcon(FontAwesomeIcons.googleDrive),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "النسخ الإحتياطي الي جوجل درايف",
                  style: myTextStyles.title2,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Switch.adaptive(
                    value: _googleUser != null,
                    inactiveTrackColor:
                        _googleUser == null ? Colors.red : Colors.green,
                    onChanged: (value) {
                      value ? _signIn() : _googleUser = null;
                      setState(() {});
                    }),
                Text(
                  "تفعيل النسخ الي جوجل درايف",
                  style: myTextStyles.subTitle.copyWith(
                      color: _googleUser == null ? Colors.red : Colors.green),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: MyColors.containerSecondColor,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _signIn,
                    child: FaIcon(
                      FontAwesomeIcons.penToSquare,
                      size: 17,
                      color: _googleUser == null ? Colors.red : Colors.green,
                    ),
                  ),
                  Text(
                    "الحساب المتصل بجوجل درايف",
                    style: myTextStyles.subTitle,
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                _googleUser == null ? "لايوجد حساب" : _googleUser?.email ?? "",
                style: myTextStyles.body,
              )
            ]),
          ),
          if (_googleUser == null)
            CustomCopyBtnWidget(
              color: Colors.green,
              icon: FontAwesomeIcons.download,
              label: "عمل نسخة جد يد ة",
              action: () {
                CustomDialog.customSnackBar("قم بربط حسابك", SnackPosition.TOP);
              },
              description:
                  "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
            ),
          if (_googleUser != null)
            CustomCopyBtnWidget(
              color: Colors.green,
              icon: FontAwesomeIcons.download,
              label: "عمل نسخة جد يد ة",
              action: () async {
                if (_driveApi == null) {
                  if (_googleUser != null) {
                    _driveApi =
                        await _googleDriveAppData.getDriveApi(_googleUser!);
                  } else {
                    _signIn();
                  }
                }
                if (_googleUser == null) {
                  return;
                }
                CustomDialog.loadingProgress();
                io.Directory path = await getApplicationDocumentsDirectory();
                String databasePath =
                    p.join(path.path, "private_account_app_database.db");

                await _googleDriveAppData.uploadDriveFile(
                  driveApi: _driveApi!,
                  file: io.File(databasePath),
                );

                Get.back();
                CustomDialog.customSnackBar(
                    "تم حفظ النسخة بنجاح", SnackPosition.TOP);
              },
              description:
                  "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
            ),
          if (_googleUser == null)
            CustomCopyBtnWidget(
              color: const Color.fromARGB(197, 149, 7, 7),
              icon: FontAwesomeIcons.upload,
              label: "فتح نسخة سابقة",
              action: () {
                CustomDialog.customSnackBar("قم بربط حسابك", SnackPosition.TOP);
              },
              description:
                  "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
            ),
          if (_googleUser != null)
            CustomCopyBtnWidget(
              color: const Color.fromARGB(197, 149, 7, 7),
              icon: FontAwesomeIcons.upload,
              label: "فتح نسخة سابقة",
              //  action: () {},
              action: () async {
                try {
                  CustomDialog.loadingProgress();

                  File? file = await _googleDriveAppData.getDriveFile(
                      _driveApi!, "account_app_copy.db");

                  if (file != null) {
                    Get.log("file is :$file");
                    io.Directory path =
                        await getApplicationDocumentsDirectory();
                    String databasePath =
                        p.join(path.path, "private_account_app_database.db");

                    await _googleDriveAppData
                        .restoreDriveFile(
                            driveApi: _driveApi!,
                            driveFile: file,
                            targetLocalPath: databasePath)
                        .then((value) {
                      print("it is complete");
                    });
                  } else {
                    Get.log("file is :$file");
                  }
                } catch (e) {
                  Get.back();
                  CustomDialog.customSnackBar("حدث خطأ ", SnackPosition.TOP);
                  return;
                } finally {
                  Get.back();
                  CustomDialog.customSnackBar(
                      "تم إسترجاع النسخة بنجاح", SnackPosition.TOP);

                  CustomDialog.showDialog(
                      title: "تنبة",
                      description: "سيتم إغلاق التطبيق قم بإعادة فتحة",
                      icon: FontAwesomeIcons.circleInfo,
                      color: Colors.red,
                      action: () {});
                  await Future.delayed(const Duration(seconds: 2));

                  io.exit(0);
                }
              },
              description:
                  "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
            ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              if (_googleUser == null) {
                await _signIn();
              }
              if (_googleUser != null) {
                _driveApi = await _googleDriveAppData.getDriveApi(_googleUser!);
                Get.to(() => ShowAllFiles(
                      driveApi: _driveApi,
                    ));
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: MyColors.lessBlackColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.solidFileLines,
                    color: MyColors.bg,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "عرض كل الملفات",
                    style: myTextStyles.subTitle.copyWith(
                      color: MyColors.bg,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Future<void> _signIn() async {
    // var credntails = SecureStorage()..getCredentials();

    if (_googleUser == null) {
      _googleUser = await _googleDriveAppData.signInGoogle();

      print("${_googleUser?.authHeaders} ");
      if (_googleUser != null) {
        _driveApi = await _googleDriveAppData.getDriveApi(_googleUser!);
      }
    } else {
      await _googleDriveAppData.signOut();
      _googleUser = null;
      _driveApi = null;
    }
    setState(() {});
  }
}

// class GoogleCopyApi {
//  static final _googleApi =  Google();

// }

class ShowAllFiles extends StatefulWidget {
  DriveApi? driveApi;
  ShowAllFiles({super.key, required this.driveApi});

  @override
  State<ShowAllFiles> createState() => _ShowAllFilesState();
}

class _ShowAllFilesState extends State<ShowAllFiles> {
  List<File>? files = [];
  bool isLoading = false;

  final GoogleDriveAppData _googleDriveAppData = GoogleDriveAppData();

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  Future<void> loadFiles() async {
    setState(() {
      isLoading = true;
    });

    List<File>? fileCopy =
        await _googleDriveAppData.getAllDriveFiles(widget.driveApi!);
    print(files);
    setState(() {
      files = fileCopy;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              CustomBackBtnWidget(
                title: " كل الملفات",
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: !isLoading
                    ? Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColors.bg,
                        ),
                        child: files?.length != null
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                                itemCount: files!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ShowFileItemWidget(
                                    file: files![index],
                                    driveApi: widget.driveApi!,
                                  );
                                },
                              )
                            : Column(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.a,
                                    size: 30,
                                    color: MyColors.lessBlackColor,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                      )
                    : Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowFileItemWidget extends StatelessWidget {
  File file;
  DriveApi driveApi;
  ShowFileItemWidget({super.key, required this.file, required this.driveApi});
  final GoogleDriveAppData _googleDriveAppData = GoogleDriveAppData();
  final googleSignIn = GoogleSignIn();

  Future<void> restoreDatabse(String fileName) async {
    if (fileName.isEmpty) {
      return;
    }
    try {
      CustomDialog.loadingProgress();

      File? file = await _googleDriveAppData.getDriveFile(driveApi, fileName);

      if (file != null) {
        Get.log("file is :$file");
        io.Directory path = await getApplicationDocumentsDirectory();
        String databasePath =
            p.join(path.path, "private_account_app_database.db");

        await _googleDriveAppData
            .restoreDriveFile(
                driveApi: driveApi,
                driveFile: file,
                targetLocalPath: databasePath)
            .then((value) {
          print("it is complete");
        });
      } else {
        Get.log("file is :$file");
      }
    } catch (e) {
      Get.back();
      CustomDialog.customSnackBar("حدث خطأ ", SnackPosition.TOP);
      return;
    } finally {
      Get.back();
      CustomDialog.customSnackBar("تم إسترجاع النسخة بنجاح", SnackPosition.TOP);

      CustomDialog.showDialog(
          title: "تنبة",
          description: "سيتم إغلاق التطبيق قم بإعادة فتحة",
          icon: FontAwesomeIcons.circleInfo,
          color: Colors.red,
          action: () {});
      await Future.delayed(const Duration(seconds: 2));

      io.exit(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomDialog.showDialog(
            title: "إستعادة نسخة",
            description: "هل انت متأكد من إستعادة هذه النسخة",
            icon: FontAwesomeIcons.circleInfo,
            color: Colors.green,
            action: restoreDatabse(file.name ?? ""));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.containerColor,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              //  padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.bg,
              ),
              child: const FaIcon(
                FontAwesomeIcons.fileCode,
                size: 40,
                color: MyColors.lessBlackColor,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                file.name ?? "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            FittedBox(
              child: Text(
                DateFormat.yMd().format(file.createdTime ?? DateTime.now()),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
            FittedBox(
              child: Text(
                DateFormat.Hm().format(file.createdTime ?? DateTime.now()),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
