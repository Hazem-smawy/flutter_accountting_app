import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/shadows.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:account_app/controller/personal_controller.dart';
import 'package:account_app/models/personal_model.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PersonalInfoScreen extends StatelessWidget {
  PersonalInfoScreen({super.key});
  PersonalController personalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => personalController.newPersonal['name'] == null
          ? Scaffold(
              body: EditPersonalInfoSheet(
              isFirstTime: true,
            ))
          : Scaffold(
              body: SafeArea(
                  child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    const CustomBackBtnWidget(title: "المعلومات الشخصيه"),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColors.bg,
                          boxShadow: [myShadow.blackShadow]),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: MyColors.lessBlackColor,
                                    child: FaIcon(
                                      FontAwesomeIcons.house,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    margin: const EdgeInsets.only(
                                        top: 10, bottom: 5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: MyColors.shadowColor)),
                                    child: Text(
                                      "اضافة صوره",
                                      style: myTextStyles.body
                                          .copyWith(fontSize: 8),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                personalController.newPersonal['name'],
                                style: myTextStyles.title2,
                              ),
                              const SizedBox(width: 10),
                              const FaIcon(
                                FontAwesomeIcons.user,
                                size: 20,
                                color: MyColors.lessBlackColor,
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                personalController.newPersonal['email'],
                                style: myTextStyles.title2.copyWith(
                                  color: MyColors.secondaryTextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const FaIcon(
                                FontAwesomeIcons.envelope,
                                size: 15,
                                color: MyColors.secondaryTextColor,
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Spacer(),
                              Text(
                                personalController.newPersonal['phone'].length <
                                        2
                                    ? "لايوجد"
                                    : personalController.newPersonal['phone'],
                                style: myTextStyles.title2.copyWith(
                                  color: MyColors.secondaryTextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.phone_outlined,
                                size: 17,
                                color: MyColors.secondaryTextColor,
                              ),
                              // const FaIcon(
                              //   FontAwesomeIcons.phoneFlip,
                              //   size: 15,
                              //   color: MyColors.secondaryTextColor,
                              // )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  Get.bottomSheet(
                                    EditPersonalInfoSheet(
                                      isFirstTime: false,
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  size: 15,
                                  color: Colors.green,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                personalController
                                            .newPersonal['address'].length <
                                        2
                                    ? "لايوجد"
                                    : personalController.newPersonal['address'],
                                style: myTextStyles.title2.copyWith(
                                  color: MyColors.secondaryTextColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.location_pin,
                                size: 18,
                                color: MyColors.secondaryTextColor,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
            ),
    );
  }
}

class EditPersonalInfoSheet extends StatelessWidget {
  EditPersonalInfoSheet({super.key, required this.isFirstTime});
  PersonalController personalController = Get.find();
  final isFirstTime;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: isFirstTime ? false : true,
      bottom: false,
      child: Container(
        // margin: EdgeInsets.only(top: Get.width / 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: personalController.newPersonal['name'] == null
              ? Colors.transparent
              : MyColors.bg,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (personalController.newPersonal['name'] == null)
                SafeArea(
                  child: CustomBackBtnWidget(title: "الإعدادات الشخصية"),
                ),
              if (personalController.newPersonal['name'] != null)
                const CustomSheetBackBtnWidget(),
              const SizedBox(height: 30),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: const [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: MyColors.lessBlackColor,
                    child: FaIcon(
                      FontAwesomeIcons.house,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                      child: CircleAvatar(
                    radius: 12,
                    backgroundColor: MyColors.primaryColor,
                    child: FaIcon(
                      FontAwesomeIcons.plus,
                      color: MyColors.bg,
                      size: 15,
                    ),
                  ))
                ],
              ),
              const SizedBox(height: 30),
              PersonalTextFieldWidget(
                textHint: "الاسم",
                icon: FontAwesomeIcons.user,
                placeHolder: personalController.newPersonal['name'] ?? "",
                action: (p0) {
                  personalController.newPersonal.update(
                    'newName',
                    (value) => p0,
                    ifAbsent: () => p0,
                  );
                },
              ),
              const SizedBox(height: 10),
              PersonalTextFieldWidget(
                textHint: "البريد ألإلكتروني",
                icon: FontAwesomeIcons.envelope,
                placeHolder: personalController.newPersonal['email'] ?? "",
                action: (p0) {
                  personalController.newPersonal.update(
                    'email',
                    (value) => p0,
                    ifAbsent: () => p0,
                  );
                },
              ),
              const SizedBox(height: 10),
              PersonalTextFieldWidget(
                textHint: "الرقم",
                icon: FontAwesomeIcons.phone,
                placeHolder: personalController.newPersonal['phone'] ?? "",
                action: (p0) {
                  personalController.newPersonal.update(
                    'phone',
                    (value) => p0,
                    ifAbsent: () => p0,
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              PersonalTextFieldWidget(
                textHint: "العنوان",
                icon: FontAwesomeIcons.locationPin,
                placeHolder: personalController.newPersonal['address'] ?? "",
                action: (p0) {
                  personalController.newPersonal.update(
                    'address',
                    (value) => p0,
                    ifAbsent: () => p0,
                  );
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Flexible(
                      child: CustomBtnWidget(
                    color: MyColors.secondaryTextColor,
                    label: "الغاء",
                    action: () {
                      personalController.newPersonal.clear();
                      Get.back();
                    },
                  )),
                  SizedBox(width: 10),
                  Flexible(
                      child: CustomBtnWidget(
                    color: MyColors.primaryColor,
                    label: 'إضافة',
                    action: () {
                      if (personalController.newPersonal['newName'] == null ||
                          personalController.newPersonal['email'] == null) {
                        CustomDialog.customSnackBar(
                            "ادخل القيم بطريقة صحيحة", SnackPosition.TOP);
                        return;
                      }
                      if (personalController.newPersonal['newName'].length <
                              1 ||
                          personalController.newPersonal['email'].length < 1) {
                        CustomDialog.customSnackBar(
                            "ادخل القيم بطريقة صحيحة", SnackPosition.TOP);
                        return;
                      }
                      var newPersonalInfo = PersonalModel(
                          id: 1,
                          name: personalController.newPersonal['newName'] ?? "",
                          email: personalController.newPersonal['email'] ?? "",
                          address:
                              personalController.newPersonal['address'] ?? "",
                          phone: personalController.newPersonal['phone'] ?? "");

                      isFirstTime
                          ? personalController.createPersona(newPersonalInfo)
                          : personalController.updatePersonal(newPersonalInfo);
                      personalController.getPersonal();
                    },
                  ))
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalTextFieldWidget extends StatelessWidget {
  final String textHint;
  final IconData icon;
  Function(String)? action;
  String? placeHolder;
  PersonalTextFieldWidget(
      {super.key,
      required this.icon,
      required this.textHint,
      this.placeHolder = "",
      required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.containerSecondColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              initialValue: placeHolder ?? "",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              style: myTextStyles.subTitle.copyWith(
                  color: MyColors.blackColor, fontWeight: FontWeight.bold),
              onChanged: (value) {
                action!(value);
                CEC.errorMessage.value = "";
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: textHint,
                hintStyle:
                    myTextStyles.body.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(width: 10),
          FaIcon(
            icon,
            size: 20,
            color: MyColors.secondaryTextColor,
          ),
          const SizedBox(width: 5),
        ],
      ),
    );
  }
}
