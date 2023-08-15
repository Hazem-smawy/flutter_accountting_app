import 'package:account_app/models/journal_model.dart';
import 'package:account_app/models/personal_model.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/service/database/tables_helpers.dart';
import 'package:get/get.dart';

class PersonalData {
  final ins = DatabaseService.instance;

  Future<PersonalModel?> create(PersonalModel personalModel) async {
    try {
      final db = await ins.database;
      final id = await db.insert(TableName.personalTbl, personalModel.toMap());
      Get.back();
      return personalModel.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  Future<PersonalModel?> readPersonal() async {
    final db = await ins.database;
    try {
      final maps = await db.query(TableName.personalTbl);

      if (maps.isNotEmpty) {
        return PersonalModel.fromMap(maps.first);
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<int?> updatePersonal(PersonalModel personalModel) async {
    final db = await ins.database;

    try {
      final updatedObject = await db.update(
          TableName.personalTbl, personalModel.toMap(),
          where: '${PersonalField.id} = ?', whereArgs: [personalModel.id]);
      Get.back();
      return updatedObject;
    } catch (e) {}
  }
}
