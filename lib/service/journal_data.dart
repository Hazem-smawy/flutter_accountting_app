import 'package:account_app/models/customer_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/service/database/tables_helpers.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class JournalData {
  final ins = DatabaseService.instance;

  Future<Journal?> create(Journal journal) async {
    try {
      final db = await ins.database;
      final id = await db.insert(TableName.journalTbl, journal.toMap());
      Get.back();
      return journal.copyWith(id: id);
    } catch (e) {
      CustomDialog.customSnackBar('هذا الاسم موجود من قبل');

      return null;
    }
  }

  Future<List<Journal>> readAllJournalForCustomerAccount(cacId) async {
    final db = await ins.database;
    final results = await db.query(
      TableName.journalTbl,
      columns: JournalField.values,
      where: '${JournalField.customerAccountId} = ?',
      whereArgs: [cacId],
    );

    return results.map((e) => Journal.fromMap(e)).toList();
  }

  Future<Journal?> readJournal(int id) async {
    final db = await ins.database;
    final maps = await db.query(
      TableName.journalTbl,
      columns: JournalField.values,
      where: '${JournalField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Journal.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Journal>> readAllJournal() async {
    final db = await ins.database;

    final result = await db.query(TableName.journalTbl);
    return result.map((e) => Journal.fromMap(e)).toList();
  }

  Future<int?> updateJournal(Journal journal) async {
    final db = await ins.database;

    try {
      final updatedObject = await db.update(
          TableName.journalTbl, journal.toMap(),
          where: '${CustomerField.id} = ?', whereArgs: [journal.id]);
      Get.back();
      return updatedObject;
    } catch (e) {
      CustomDialog.customSnackBar('هذا الاسم موجود من قبل');
    }
  }

  Future<int> delete(int id) async {
    final db = await ins.database;
    return await db.delete(TableName.journalTbl,
        where: '${CustomerField.id} = ?', whereArgs: [id]);
  }
}
