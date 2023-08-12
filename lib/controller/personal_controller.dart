import 'package:account_app/models/personal_model.dart';
import 'package:account_app/service/personal_data.dart';
import 'package:get/get.dart';

class PersonalController extends GetxController {
  PersonalData personalData = PersonalData();
  var newPersonal = {}.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<PersonalModel?> getPersonal(int id) async {
    var newPer = await personalData.readPersonal(id);
    newPersonal.addAll(newPer?.toMap() ?? {});
    return newPer;
  }

  Future<void> createPersona(PersonalModel personalModel) async {
    personalData.create(personalModel);
  }

  Future<void> updatePersonal(PersonalModel persoanl) async {
    personalData.updatePersonal(persoanl);
  }
}
