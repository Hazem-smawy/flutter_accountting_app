import 'package:account_app/models/curency_model.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/service/database/tables_helpers.dart';

class CurencyData {
  final ins = DatabaseService.instance;

 Future<Curency> create(Curency curency) async {
    final db = await ins.database;
    final id = await db.insert(TableName.curencyTbl, curency.toMap());

    return curency.copyWith(id: id);
  }

  Future<Curency?> readCurency(int id) async {
    final db = await ins.database;
    final maps = await db.query(
      TableName.curencyTbl,
      columns: CurencyField.values,
      where: '${CurencyField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Curency.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Curency>> readAllCurencies() async {
    final db = await ins.database;

    final result = await db.query(TableName.curencyTbl);
    return result.map((e) => Curency.fromMap(e)).toList();
  }

  Future<int> updateCurency(Curency curency) async {
    final db = await ins.database;
    return db.update(TableName.curencyTbl, curency.toMap(),
        where: '${CurencyField.id} = ?', whereArgs: [curency.id]);
  }

  Future<int> delete(int id) async {
    final db = await ins.database;
    return await db
        .delete(TableName.curencyTbl, where: '${CurencyField.id} = ?', whereArgs: [id]);
  }


}
