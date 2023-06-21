// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:account_app/screen/home/home_row.dart';
import 'package:account_app/screen/home/summary_item_widget.dart';
import 'package:account_app/widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/screen/new_account/new_account.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      endDrawer: const MyDrawerView(),
      body: SafeArea(
        child: Column(
          children: [
            MyAppBarWidget(globalKey: _globalKey),
            const SizedBox(height: 10),
            const Padding(
              padding:  EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: _homeSammaryWidget(),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return HomeRowView(
                        color: index % 2 == 0 ? Colors.red : Colors.green,
                        icon: index % 2 == 0
                            ? FontAwesomeIcons.chevronDown
                            : FontAwesomeIcons.chevronUp);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: MyColors.primaryColor,
        onPressed: () => Get.to(() => const NewAccountScreen()),
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class _homeSammaryWidget extends StatelessWidget {
  const _homeSammaryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        HomeSammaryWidget(
          icon: FontAwesomeIcons.angleDown,
          title: "1000",
          subTitle: "عليك",
          color: Colors.red,
        ),
        SizedBox(
          width: 10,
        ),
        HomeSammaryWidget(
          icon: FontAwesomeIcons.angleUp,
          title: "2000",
          subTitle: "لك",
          color: Colors.green,
        )
      ],
    );
  }
}

class MyAppBarWidget extends StatelessWidget {
  const MyAppBarWidget({
    super.key,
    required GlobalKey<ScaffoldState> globalKey,
  }) : _globalKey = globalKey;

  final GlobalKey<ScaffoldState> _globalKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.lessBlackColor,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.filter,
            size: 20,
            color: MyColors.containerColor,
          ),
          const Spacer(),
          Text(
            "محلي",
            style: myTextStyles.title1.copyWith(color: MyColors.containerColor),
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              _globalKey.currentState?.openEndDrawer();
            },
            child: const FaIcon(
              FontAwesomeIcons.bars,
              color: MyColors.containerColor,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
