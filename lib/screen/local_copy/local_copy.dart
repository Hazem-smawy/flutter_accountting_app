import 'dart:io';

import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/acc_curency_controller.dart';
import 'package:account_app/screen/local_copy/folder_copy.dart';
import 'package:account_app/screen/local_copy/google_drive_copy.dart';
import 'package:account_app/widget/custom_btns_widges.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class LocalCopyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: const [
              CustomBackBtnWidget(title: " النسخ الإ حتياطي"),
              SizedBox(
                height: 20,
              ),
              FolderCopyWidget(),
              SizedBox(
                height: 20,
              ),
              GoogleDriveCopyWidget(),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
