import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/intro_controller.dart';
import 'package:account_app/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
      "image": "assets/images/customer.png",
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
  final controller = PageController();
  IntroController introController = Get.find();

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
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.previousPage(
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.bounceInOut);
                                },
                                child: Padding(
                                    padding: EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: FaIcon(
                                      FontAwesomeIcons.arrowRightLong,
                                      color: MyColors.secondaryTextColor,
                                      size: 20,
                                    )),
                              ),
                            ],
                          ),
                        FirstPage(
                          page: pages[index],
                        ),
                        Spacer(),
                        if (index == pages.length - 1)
                          GestureDetector(
                            onTap: () {
                              introController.updateIntro();
                              Get.to(() => ShowMyMainScreen());
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color.fromARGB(255, 64, 203, 143)
                                    .withOpacity(0.7),
                              ),
                              child: Text(
                                "الصفحة الرئيسية",
                                style: myTextStyles.title2.copyWith(
                                  color: MyColors.bg,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    );
                  }),
            ),
            if (i != pages.length - 1)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  textDirection: TextDirection.rtl,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
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
                        child: Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: pages
                              .map(
                                (e) => AnimatedContainer(
                                  duration: Duration(microseconds: 200),
                                  margin: EdgeInsets.only(left: 5),
                                  width: e['id'] == i ? 15 : 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: e['id'] == i
                                        ? Color.fromARGB(255, 88, 223, 162)
                                        : Colors.white,
                                  ),
                                ),
                              )
                              .toList()),
                    )),
                    GestureDetector(
                      onTap: () {
                        controller.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.decelerate,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
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
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Image.asset(
            page['image'],
            width: Get.width - 100,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            page['title'],
            style: myTextStyles.title2.copyWith(
              color: MyColors.containerColor,
              fontWeight: FontWeight.normal,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              page['desc'],
              textAlign: TextAlign.center,
              style: myTextStyles.body.copyWith(
                color: MyColors.secondaryTextColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
