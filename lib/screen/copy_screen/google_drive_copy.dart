import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/copy_controller.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:account_app/widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:googleapis/drive/v3.dart';

import 'package:intl/intl.dart';

class GoogleDriveCopyWidget extends StatefulWidget {
  GoogleDriveCopyWidget({super.key});

  @override
  State<GoogleDriveCopyWidget> createState() => _GoogleDriveCopyWidgetState();
}

class _GoogleDriveCopyWidgetState extends State<GoogleDriveCopyWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //  padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColors.bg,
        ),
        child: GetBuilder<CopyController>(builder: (contorller) {
          if (contorller.googleUser == null) {
            contorller.signIn();
          }
          return Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                padding: const EdgeInsets.only(top: 20, left: 10, right: 20),
                child: Column(
                  children: [
                    const FaIcon(FontAwesomeIcons.googleDrive),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "النسخ الإ حتياطي الى جوجل درايف",
                      style: myTextStyles.title2,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: MyColors.background,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Switch.adaptive(
                        value: contorller.googleUser != null,
                        inactiveTrackColor: contorller.googleUser == null
                            ? Colors.red
                            : Colors.green,
                        onChanged: (value) {
                          value ? contorller.signIn() : contorller.signOut();
                        }),
                    Text(
                      "تفعيل النسخ الى جوجل درايف",
                      style: myTextStyles.subTitle.copyWith(
                          color: contorller.googleUser == null
                              ? Colors.red
                              : Colors.green),
                    ),
                  ],
                ),
              ),
              if (contorller.googleUser != null)
                Column(
                  children: [
                    CustomCopyBtnWidget(
                      color: Colors.green,
                      icon: FontAwesomeIcons.download,
                      label: "عمل نسخة جد يد ة",
                      action: () async {
                        await contorller.uploadCopy();
                      },
                      description:
                          "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
                    ),
                    CustomDriveCopyBtnWidget(
                      color: const Color.fromARGB(197, 149, 7, 7),
                      icon: FontAwesomeIcons.upload,
                      label: "فتح إخر نسخة ",
                      //  action: () {},
                      action: () {
                        contorller.getTheLastFile();
                      },
                      description:
                          "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.lessBlackColor.withOpacity(0.1),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    contorller.signOut();
                                    contorller.signIn();
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.penToSquare,
                                    size: 17,
                                    color: contorller.googleUser == null
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                                Text(
                                  "الحساب المتصل بجوجل درايف",
                                  style: myTextStyles.body.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              contorller.googleUser == null
                                  ? "لايوجد حساب"
                                  : contorller.googleUser?.email ?? "",
                              style: myTextStyles.title2,
                            )
                          ]),
                    ),
                  ],
                ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        }));
  }
}

// class GoogleCopyApi {
//  static final _googleApi =  Google();

// }

class ShowAllFiles extends StatefulWidget {
  ShowAllFiles({super.key});

  @override
  State<ShowAllFiles> createState() => _ShowAllFilesState();
}

class _ShowAllFilesState extends State<ShowAllFiles> {
  List<File>? files = [];
  bool isLoading = false;

  CopyController copyController = Get.find();

  @override
  void initState() {
    super.initState();
    loadFiles();
  }

  Future<void> loadFiles() async {
    setState(() {
      isLoading = true;
    });

    List<File>? fileCopy = await copyController.getAllFiles();

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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: !isLoading
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColors.bg,
                        ),
                        child: files?.length != null && files!.length > 0
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 1 / 1.2),
                                itemCount: files!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ShowFileItemWidget(
                                    file: files![index],
                                    action: () async {
                                      await loadFiles();
                                    },
                                  );
                                },
                              )
                            : EmptyWidget(
                                imageName: 'assets/images/notfound1.png',
                                label: "لاتوجد أي نسخة ",
                              ),
                      )
                    : const Center(
                        child: SizedBox(
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
  VoidCallback action;

  ShowFileItemWidget({super.key, required this.file, required this.action});

  CopyController copyController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomDialog.showDialog(
          title: "إستعادة",
          description: "هل انت متأكد من إستعادة هذه النسخة",
          icon: FontAwesomeIcons.circleInfo,
          color: Colors.green,
          action: () {
            Get.back();
            copyController.getSlelectedCopy(file);
          },
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyColors.containerColor,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  //  padding: EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.bg,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.database,
                    size: 40,
                    color: MyColors.lessBlackColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    file.name ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyColors.lessBlackColor,
                  ),
                  child: FittedBox(
                    child: Text(
                      DateFormat.yMd()
                          .format(file.modifiedTime ?? DateTime.now()),
                      style: const TextStyle(
                        color: MyColors.bg,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Text(
                    DateFormat.Hm().format(file.modifiedTime ?? DateTime.now()),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 5,
            bottom: 5,
            child: GestureDetector(
              onTap: () {
                if (Get.isSnackbarOpen != true) {
                  CustomDialog.showDialog(
                    title: "حذف",
                    description: "هل انت متأكد من حذف هذه النسخة",
                    icon: FontAwesomeIcons.circleInfo,
                    color: Colors.red,
                    action: () async {
                      Get.back();
                      CustomDialog.loadingProgress();

                      await copyController.deleteDriveFile(file);
                      action();
                      Get.back();
                      CustomDialog.customSnackBar(
                          "تم الحذف بنجاح", SnackPosition.TOP);
                    },
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.bg.withOpacity(0.5),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.trash,
                  size: 15,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDriveCopyBtnWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final description;
  VoidCallback action;
  CustomDriveCopyBtnWidget(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.description,
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor,
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
              style: myTextStyles.body,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    Get.to(() => ShowAllFiles());
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: MyColors.lessBlackColor.withOpacity(0.8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "عرض كل الملفات",
                          style: myTextStyles.subTitle.copyWith(
                            color: MyColors.bg,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.solidFileLines,
                          color: MyColors.bg,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    action();
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    //  margin: const EdgeInsets.symmetric(horizontal: 10),
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
                        const SizedBox(
                          width: 10,
                        ),
                        FaIcon(
                          icon,
                          size: 15,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
