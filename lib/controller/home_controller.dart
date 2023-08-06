import 'package:account_app/models/home_model.dart';
import 'package:account_app/service/database/database_service.dart';
import 'package:account_app/service/home_data.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeData homeData = HomeData();

  var openDrawer = false.obs;
  var curencyId = "".obs;
  var curency = {}.obs;
  var isCurenciesOpen = false.obs;
  var homeRowsData = <HomeModel>[].obs;
  var allHomeData = <HomeModel>[].obs;
  RxList<HomeModel> loadData = <HomeModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    getCustomerAccountsFromCurencyAndAccGroupIds();
    super.onInit();
  }

  void setCurency(GroupCurency gc) {
    curency.addAll(gc.toMap());
  }

  Future<List<GroupCurency>> getCurencyInAccGroup(int accGroupId) async {
    var res = await homeData.getCurencyInAccGroup(accGroupId);
    curency.addAll(res.first.toMap());
    getCustomerAccountsFromCurencyAndAccGroupIds();
    return res;
  }

  Future<List<HomeModel>> getCustomerAccountsFromCurencyAndAccGroupIds() async {
    loadData.value = await homeData.getCustomerAccountsForAccGroup();
    return loadData;
  }
}
