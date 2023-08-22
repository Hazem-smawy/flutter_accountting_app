import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/service/database/home_data.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeData homeData = HomeData();
  CurencyController curencyController = Get.find();

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
    if (curencyController.selectedCurency['crId'] == null) {
      curencyController.selectedCurency.addAll(res.first.toMap());
    } else {
      var currentCurency = res.firstWhereOrNull((element) =>
          element.crId == curencyController.selectedCurency['crId']);

      if (currentCurency == null) {
        curencyController.selectedCurency.addAll(res.first.toMap());
      }
    }
    return res;
  }

  Future<List<HomeModel>> getCustomerAccountsFromCurencyAndAccGroupIds() async {
    loadData.value = await homeData.getCustomerAccountsForAccGroup();
    return loadData;
  }
}
