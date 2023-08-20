import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleDriveCopyWidget extends StatelessWidget {
  const GoogleDriveCopyWidget({super.key});

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
                Switch.adaptive(value: true, onChanged: (value) {}),
                Text(
                  "تفعيل النسخ الي جوجل درايف",
                  style: myTextStyles.subTitle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
                    child: const FaIcon(
                      FontAwesomeIcons.penToSquare,
                      size: 17,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    "الحساب المتصل بجوجل درايف",
                    style: myTextStyles.subTitle,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("hazemsmawy@gmail.com")
            ]),
          ),
          CustomCopyBtnWidget(
            color: Colors.green,
            icon: FontAwesomeIcons.download,
            label: "عمل نسخة جد يد ة",
            action: () {},
            description:
                "إذا احتجت في أي وقت إلى نسخة احتياطية بديلة، فيمكنك نسخ بيانات جهازك احتياطيًا باستخدام",
          ),
          CustomCopyBtnWidget(
            color: const Color.fromARGB(197, 149, 7, 7),
            icon: FontAwesomeIcons.upload,
            label: "فتح نسخة سابقة",
            //  action: () {},
            action: () {},
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

  Future _signIn() async {
    final googleSignIn = GoogleSignIn();

    try {
      final cra = await googleSignIn.signIn();
      print(cra);
    } catch (error) {
      print(error);
    }
  }
}

// class GoogleCopyApi {
//  static final _googleApi =  Google();

// }
