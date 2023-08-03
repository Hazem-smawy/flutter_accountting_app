import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/service/database/tables_helpers.dart';
import 'package:sqflite/sqflite.dart';

class CustomerAccountData {
  final ins = DatabaseService.instance;

  Future<CustomerAccount> create(CustomerAccount customerAccount) async {
    final db = await ins.database;
    final id =
        await db.insert(TableName.customerAccountTbl, customerAccount.toMap());

    return customerAccount.copyWith(id: id);
  }

  Future<CustomerAccount?> readCustomerAccount(int id) async {
    final db = await ins.database;
    final maps = await db.query(
      TableName.customerAccountTbl,
      columns: CustomerAccountField.values,
      where: '${CustomerAccountField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CustomerAccount.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<CustomerAccount>> readAllCustomerAccounts() async {
    final db = await ins.database;

    final result = await db.query(TableName.customerAccountTbl);
    return result.map((e) => CustomerAccount.fromMap(e)).toList();
  }

  Future<int> updateCustomerAccount(CustomerAccount customerAccount) async {
    final db = await ins.database;
    return db.update(TableName.customerAccountTbl, customerAccount.toMap(),
        where: '${CustomerField.id} = ?', whereArgs: [customerAccount.id]);
  }

  Future<int> delete(int id) async {
    final db = await ins.database;
    return await db.delete(TableName.customerAccountTbl,
        where: '${CustomerAccountField.id} = ?', whereArgs: [id]);
  }

  Future<CustomerAccount?> isCustomerAccountExist(
      {required int customerId,
      required int accGroupId,
      required int curencyId}) async {
    final db = await ins.database;
    var maps = await db.rawQuery(
        "SELECT id FROM ${TableName.customerAccountTbl}  WHERE ${CustomerAccountField.customerId} = ? AND ${CustomerAccountField.accgroupId} = ? AND ${CustomerAccountField.curencyId} = ?",
        [customerId, accGroupId, curencyId]);
    //int? count = Sqflite.firstIntValue(row);
    if (maps.isNotEmpty) {
      return CustomerAccount.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
