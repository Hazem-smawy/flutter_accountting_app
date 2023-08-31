import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/sitting_model.dart';
import 'package:account_app/service/database/helper/database_helper.dart';
import 'package:account_app/service/database/helper/database_service.dart';
import 'package:sqflite/sqflite.dart';

class SittingData {
  Future<void> createTable(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS sitting (
          id ${FieldType.idType},
          every ${FieldType.integerType} ,
          isCopyOn ${FieldType.boolType}
        );
    ''');
  }

  Future<SittingModel?> create(SittingModel sittingModel) async {
    final db = await DatabaseService().database;
    final id = await db.insert('sitting', sittingModel.toMap());

    return sittingModel.copyWith(id: id);
  }

  Future<SittingModel?> read(int id) async {
    final db = await DatabaseService().database;
    final maps = await db.query(
      'sitting',
      columns: ['id', 'every', 'isCopyOn'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return SittingModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int?> update(SittingModel sittingModel) async {
    final db = await DatabaseService().database;
    print(sittingModel);
    try {
      final upOb = await db.update('sitting', sittingModel.toMap(),
          where: 'id= ?', whereArgs: [sittingModel.id]);

      return upOb;
    } catch (e) {}
  }

  Future<int> delete(int id) async {
    final db = await DatabaseService().database;
    return await db.delete('sitting', where: 'id = ?', whereArgs: [id]);
  }
}
