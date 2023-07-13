import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/service/database/tables_helpers.dart';

class AccGroupData {
  final ins = DatabaseService.instance;

 Future<AccGroup> create(AccGroup accGroup) async {
    final db = await ins.database;
    final id = await db.insert(TableName.accGroupTbl, accGroup.toMap());

    return accGroup.copyWith(id: id);
  }

  Future<AccGroup?> readAccGroup(int id) async {
    final db = await ins.database;
    final maps = await db.query(
      TableName.accGroupTbl,
      columns: AccGroupField.values,
      where: '${AccGroupField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AccGroup.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<AccGroup>> readAllAccGroups() async {
    final db = await ins.database;

    final result = await db.query(TableName.accGroupTbl);
    return result.map((e) => AccGroup.fromMap(e)).toList();
  }

  Future<int> updateAccGroup(AccGroup accGroup) async {
    final db = await ins.database;
    return db.update(TableName.accGroupTbl, accGroup.toMap(),
        where: '${AccGroupField.id} = ?', whereArgs: [accGroup.id]);
  }

  Future<int> delete(int id) async {
    final db = await ins.database;
    return await db
        .delete(TableName.accGroupTbl, where: '${AccGroupField.id} = ?', whereArgs: [id]);
  }


}
