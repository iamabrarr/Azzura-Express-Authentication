import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';

class ButtonsController extends GetxController {
  //FOR LOADING
  RxBool isLoading=false.obs;
  //FOR AUTH
  RxString countryCode = "33".obs;
  RxString country = "".obs;
  RxString city = "".obs;
  RxString state = "".obs;
}
