import 'package:account_app/service/database/helper/database_service.dart';
import 'package:flutter/material.dart';

class IntroData {
  final ins = DatabaseService.instance;

  Future<void> create() async {
    try {
      final db = await ins.database;
      await db.insert('intro', {"id": 1, "isShow": 0});
    } catch (e) {
      print("error for creatting");
    }
  }

  Future<bool> read() async {
    try {
      final db = await ins.database;
      final result = await db.query('intro');
      final value = result.first['isShow'];
      print(value);
      return value == 1;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> update() async {
    try {
      final db = await ins.database;
      final result = await db.update('intro', {"id": 1, "isShow": 1});
      print("updated: $result");
      return result;
    } catch (e) {
      print("error for update");
      return 0;
    }
  }
}
