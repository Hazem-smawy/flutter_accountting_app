import 'dart:async';
import 'dart:io';

import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/models/customer_account.dart';
import 'package:account_app/models/customer_model.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/models/personal_model.dart';
import 'package:account_app/service/database/database_helper.dart';
import 'package:account_app/service/database/tables_helpers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;
  static DatabaseService instance = DatabaseService._init();

  DatabaseService._init();
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();

    return _database!;
  }

  // Stream<List<HomeModel>> getallHomeRows() {
  //   return _database
  //           ?.rawQuery(
  //               'SELECT cac.customerId AS caId, ca.name ,cac.id AS cacId,totalDebit ,cac.totalCredit , cac.operation, cac.accgroupId AS accGId,cac.curencyId AS curId FROM customeraccount AS cac  JOIN  customer AS ca ON cac.customerId = ca.id ')
  //           .asStream()
  //           .map((event) => event.map((e) => HomeModel.fromMap(e)).toList()) ??
  //       Stream.empty();
  // }

  Future<String> get fullPath async {
    Directory path = await getApplicationDocumentsDirectory();
    String databasePath = join(path.path, "account_databse.db");

    return databasePath;
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(path,
        version: 1, onCreate: _create, onOpen: (db) {});

    return database;
  }

  Future<void> _create(Database db, int version) async {
    await db.execute('''
      CREATE TABLE intro (
         ${CurencyField.id} ${FieldType.idType},
        isShow ${FieldType.boolType})

    ''');
    await db.execute('''
        CREATE TABLE ${TableName.curencyTbl} (
          ${CurencyField.id} ${FieldType.idType},
          ${CurencyField.name} ${FieldType.textType} UNIQUE,
          ${CurencyField.symbol} ${FieldType.textType},
          ${CurencyField.status} ${FieldType.boolType},
          ${CurencyField.createdAt} ${FieldType.timeType},
          ${CurencyField.modifiedAt} ${FieldType.timeType}


        )
    ''');
    await db.execute('''
        CREATE TABLE ${TableName.customerTbl} (
          ${CustomerField.id} ${FieldType.idType},
          ${CustomerField.name} ${FieldType.textType} UNIQUE,
          ${CustomerField.phone} ${FieldType.textType},
          ${CustomerField.address} ${FieldType.textType},
          ${CustomerField.status} ${FieldType.boolType},
          ${CustomerField.createdAt} ${FieldType.timeType},
          ${CustomerField.modifiedAt} ${FieldType.timeType}


        )
    ''');

    await db.execute('''
        CREATE TABLE ${TableName.accGroupTbl} (
          ${AccGroupField.id} ${FieldType.idType},
          ${AccGroupField.name} ${FieldType.textType} UNIQUE,
          ${AccGroupField.status} ${FieldType.boolType},
          ${AccGroupField.createdAt} ${FieldType.timeType},
          ${AccGroupField.modifiedAt} ${FieldType.timeType}


        )
    ''');

    await db.execute('''
        CREATE TABLE ${TableName.customerAccountTbl} (
          ${CustomerAccountField.id} ${FieldType.idType},
          ${CustomerAccountField.customerId} ${FieldType.integerType},
          ${CustomerAccountField.curencyId} ${FieldType.integerType},
          ${CustomerAccountField.accgroupId} ${FieldType.integerType},
          ${CustomerAccountField.totalCredit} ${FieldType.doubleType},
          ${CustomerAccountField.totalDebit} ${FieldType.doubleType},
          ${CustomerAccountField.createdAt} ${FieldType.timeType},
          ${CustomerAccountField.operation} ${FieldType.integerType},
          ${CustomerAccountField.status} ${FieldType.boolType}
        
        )
    ''');
    /* 
 
          FOREIGN KEY(${CustomerAccountField.customerId}) REFERENCES ${TableName.customerTbl}(id) on DELETE CASCADE ,
          FOREIGN KEY(${CustomerAccountField.accgroupId}) REFERENCES ${TableName.accGroupTbl}(id) on DELETE CASCADE ,
          FOREIGN KEY(${CustomerAccountField.curencyId}) REFERENCES ${TableName.curencyTbl}(id) on DELETE CASCADE 

 */
    await db.execute('''
        CREATE TABLE ${TableName.journalTbl} (
          ${JournalField.id} ${FieldType.idType},
          ${JournalField.customerAccountId} ${FieldType.integerType},
          ${JournalField.details} ${FieldType.textType},
          ${JournalField.registeredAt} ${FieldType.timeType},
          ${JournalField.credit} ${FieldType.doubleType},
          ${JournalField.debit} ${FieldType.doubleType},
          ${JournalField.createdAt} ${FieldType.timeType},
          ${JournalField.modifiedAt} ${FieldType.timeType}
         
        )
    ''');
    await db.execute('''
        CREATE TABLE ${TableName.personalTbl} (
          ${PersonalField.id} ${FieldType.idType},
          ${PersonalField.name} ${FieldType.textType},
          ${PersonalField.phone} ${FieldType.textType},
          ${PersonalField.email} ${FieldType.textType},
          ${PersonalField.address} ${FieldType.textType}
         
         
        )
    ''');
    //  FOREIGN KEY(${JournalField.customerAccountId}) REFERENCES ${TableName.customerAccountTbl}(id) on DELETE CASCADE
  }
}
