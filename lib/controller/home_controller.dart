import 'package:account_app/models/home_model.dart';
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

    // allHomeData.bindStream(homeData.getAllHomeModelData() ?? Stream.empty());

    super.onInit();
  }

  void setCurency(GroupCurency gc) {
    curency.addAll(gc.toMap());
  }

  Future<List<GroupCurency>> getCurencyInAccGroup(int accGroupId) async {
    var res = await homeData.getCurencyInAccGroup(accGroupId);
    curency.addAll(res.first.toMap());
    return res;
  }

  Future<List<HomeModel>> getCustomerAccountsFromCurencyAndAccGroupIds(
      int accGroupId) async {
    if (curency['crId'] != null) {
      loadData.value = await homeData.getCustomerAccountsForAccGroup(
          accGroupId, curency['crId']);

      return loadData;
    }
    return [];
  }
}
