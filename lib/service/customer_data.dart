import 'package:account_app/models/customer_model.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/service/database/tables_helpers.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:get/get.dart';

class CustomerData {
  final ins = DatabaseService.instance;

  Future<Customer?> create(Customer customer) async {
    try {
      final db = await ins.database;
      final id = await db.insert(TableName.customerTbl, customer.toMap());
      Get.back();
      return customer.copyWith(id: id);
    } catch (e) {
      CustomDialog.customSnackBar('هذا الاسم موجود من قبل');
    }
  }

  Future<Customer?> readCustomer(int id) async {
    final db = await ins.database;
    final maps = await db.query(
      TableName.customerTbl,
      columns: CustomerField.values,
      where: '${CustomerField.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Customer.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Customer>> readAllCustomers() async {
    final db = await ins.database;

    final result = await db.query(TableName.customerTbl);
    return result.map((e) => Customer.fromMap(e)).toList();
  }

  Future<int?> updateCustomer(Customer customer) async {
    final db = await ins.database;
    

         try {
      final updatedObject = await db.update(TableName.customerTbl, customer.toMap(),
        where: '${CustomerField.id} = ?', whereArgs: [customer.id]);
      Get.back();
      return updatedObject;
    } catch (e) {
      CustomDialog.customSnackBar('هذا الاسم موجود من قبل');
    }
  }

  Future<int> delete(int id) async {
    final db = await ins.database;
    return await db.delete(TableName.customerTbl,
        where: '${CustomerField.id} = ?', whereArgs: [id]);
  }
}
