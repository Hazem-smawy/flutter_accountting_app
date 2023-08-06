import 'package:account_app/models/home_model.dart';
import 'package:account_app/service/database/database_service.dart';

class HomeData {
  final ins = DatabaseService.instance;

  Future<List<GroupCurency>> getCurencyInAccGroup(int accGroupId) async {
    var db = await ins.database;
    var result = await db.rawQuery(
        'SELECT cac.curencyId AS crId ,cr.name AS name, cr.symbol AS symbol from customeraccount AS cac JOIN curency AS cr ON cac.curencyId = cr.id WHERE cac.accgroupId = $accGroupId  GROUP BY cac.curencyId');

    return result.map((e) => GroupCurency.fromMap(e)).toList();
  }

  Future<List<HomeModel>> getCustomerAccountsForAccGroup() async {
    var db = await ins.database;
    final result = await db.rawQuery(
        'SELECT cac.customerId AS caId, ca.name ,cac.id AS cacId,totalDebit ,cac.totalCredit , cac.operation, cac.accgroupId AS accGId,cac.curencyId AS curId FROM customeraccount AS cac  JOIN  customer AS ca ON cac.customerId = ca.id ');
    //WHERE cac.accgroupId = $accGroupId AND cac.curencyId = $curencyId
    final lastRes = result.map((e) => HomeModel.fromMap(e)).toList();

    return lastRes;
  }
}
