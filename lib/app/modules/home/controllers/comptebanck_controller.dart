
import 'package:e_banck/app/modules/home/model/comptebanck_model.dart';
import 'package:e_banck/app/data/api_provider.dart';
import 'package:get/get.dart';

class CompteBanck extends GetxController {
  final ApiProvider _apiProvider = ApiProvider();
  var numbanck = <ComptebanckModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllCodeBanck();
  }

  void fetchAllCodeBanck() async {
    final response = await _apiProvider.getAgent();
    numbanck.value = response.map((data) =>ComptebanckModel.fromJson(data)).toList();
  }
  

  // void addCodeBanck(String code) async {
  //   final Map<String, dynamic>? Newnumbanck =
  //       await _apiProvider.addAgent(code);
  //   if (Newnumbanck != null) {
  //     numbanck.add(ComptebanckModel.fromJson(Newnumbanck));           
  //   } 
  //   fetchAllCodeBanck();
  // }

  // void updateAgent(int id, String name, String description) async {
  //   final updatedAgent = await _apiProvider.updateAgent(id, name, description);
  //   final index = agent.indexWhere((u) => u.id == id);
  //   if (index != -1) {
  //     agent[index] = ComptebanckModel.fromJson(updatedAgent!);
  //   }     
  //    fetchAgent();
  // }

  // void deleteAgent(int id) async {
  //   final success = await _apiProvider.deleteAgent(id);
  //   if (success) {
  //     agent.removeWhere((u) => u.id == id);
  //   }
  //   fetchAgent();
  // }
}
