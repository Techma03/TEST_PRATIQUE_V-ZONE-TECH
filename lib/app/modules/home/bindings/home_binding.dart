import 'package:e_banck/app/modules/home/controllers/comptebanck_controller.dart';
import 'package:get/get.dart';

class ComptebanckBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompteBanck>(
      () => CompteBanck(),
    );
  }
}
