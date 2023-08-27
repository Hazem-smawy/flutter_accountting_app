import 'package:account_app/models/journal_model.dart';
import 'package:account_app/models/personal_model.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:account_app/service/database/helper/tables_helpers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:account_app/service/database/helper/database_helper.dart';

class PersonalData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE  IF NOT EXISTS ${TableName.personalTbl} (
          ${PersonalField.id} ${FieldType.idType},
          ${PersonalField.name} ${FieldType.textType},
          ${PersonalField.phone} ${FieldType.textType},
          ${PersonalField.email} ${FieldType.textType},
          ${PersonalField.address} ${FieldType.textType}
         


        );
    ''');
  }

  Future<PersonalModel?> create(PersonalModel personalModel) async {
    try {
      final db = await DatabaseService().database;
      final id = await db.insert(TableName.personalTbl, personalModel.toMap());
      Get.back();
      return personalModel.copyWith(id: id);
    } catch (e) {
      return null;
    }
  }

  Future<PersonalModel?> readPersonal() async {
    final db = await DatabaseService().database;
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
    final db = await DatabaseService().database;

    try {
      final updatedObject = await db.update(
          TableName.personalTbl, personalModel.toMap(),
          where: '${PersonalField.id} = ?', whereArgs: [personalModel.id]);
      Get.back();
      return updatedObject;
    } catch (e) {}
  }
}
