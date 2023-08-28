import 'package:account_app/controller/accgroup_controller.dart';
import 'package:account_app/controller/curency_controller.dart';
import 'package:account_app/models/accgroup_model.dart';
import 'package:account_app/models/curency_model.dart';
import 'package:account_app/models/home_model.dart';
import 'package:account_app/models/journal_model.dart';
import 'package:account_app/service/database/home_data.dart';
import 'package:account_app/widget/custom_dialog.dart';
import 'package:get/get.dart';
import 'package:googleapis/photoslibrary/v1.dart';

class HomeController extends GetxController {
  HomeData homeData = HomeData();
  CurencyController curencyController = Get.find();
  AccGroupController accGroupController = Get.find();

  var openDrawer = false.obs;
  var curencyId = "".obs;
  var curency = {}.obs;
  var isCurenciesOpen = false.obs;
  var homeRowsData = <HomeModel>[].obs;
  var allHomeData = <HomeModel>[].obs;
  RxList<HomeModel> loadData = <HomeModel>[].obs;

  RxList<dynamic> todaysJournals = [].obs;

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

  Future<void> getTheTodaysJournals() async {
    todaysJournals.value = await homeData.getTodayJournals();
  }

  Future<void> addDefaultAccGroupsAndCurency() async {
    var curencies = [
      Curency(
          name: "ريال يمني",
          symbol: "ر.ي",
          status: true,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now()),
      Curency(
          name: "ريال سعودي",
          symbol: "ر.س",
          status: true,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now()),
      Curency(
          name: "دولار أمريكي",
          symbol: "د.أ",
          status: true,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now()),
    ];
    var accGroups = [
      AccGroup(
          name: "شخصي",
          status: true,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now()),
      AccGroup(
          name: "المورين",
          status: true,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now()),
      AccGroup(
          name: "الموزعين",
          status: true,
          createdAt: DateTime.now(),
          modifiedAt: DateTime.now()),
    ];
    curencies.forEach((element) {
      curencyController.createCurency(element);
      Future.delayed(const Duration(milliseconds: 50));
    });
    accGroups.forEach((element) {
      accGroupController.createAccGroup(element);
      Future.delayed(const Duration(milliseconds: 50));
    });

    await Future.delayed(const Duration(milliseconds: 200));
  }
}
