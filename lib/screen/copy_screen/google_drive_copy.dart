import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/service/http_service/google_drive_service.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
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

  GoogleSignInAccount? _googleUser;

  DriveApi? _driveApi;

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
                CustomDialog.loadingProgress();
                io.Directory path = await getApplicationDocumentsDirectory();
                String databasePath =
                    p.join(path.path, "account_app_database.db");

                _googleDriveAppData.uploadDriveFile(
                  driveApi: _driveApi!,
                  file: io.File(databasePath),
                );
                Future.delayed(Duration(milliseconds: 200)).then((value) {
                  if (Get.isDialogOpen ?? false) {
                    Get.back();
                    CustomDialog.customSnackBar(
                        "تم حفظ النسخة بنجاح", SnackPosition.TOP);
                  }
                });

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
                        p.join(path.path, "account_app_database.db");

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
                  print(e);
                } finally {
                  Future.delayed(Duration(milliseconds: 200)).then((value) {
                    if (Get.isDialogOpen ?? false) {
                      Get.back();
                      CustomDialog.customSnackBar(
                          "تم إسترجاع النسخة بنجاح", SnackPosition.TOP);
                    }
                  });

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
    }
    setState(() {});
  }
}

// class GoogleCopyApi {
//  static final _googleApi =  Google();

// }
