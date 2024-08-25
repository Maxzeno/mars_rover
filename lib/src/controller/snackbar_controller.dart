import 'package:get/route_manager.dart';
import 'package:mars_rover/src/constant.dart';

class MySnackbarController {
  static void errorSnack(msg) {
    Get.showSnackbar(GetSnackBar(
      title: "Failed",
      message: "$msg",
      backgroundColor: kRedColor,
      duration: const Duration(seconds: 2),
    ));
  }

  static void successSnack(msg) {
    Get.showSnackbar(GetSnackBar(
      title: "Successful",
      message: "$msg",
      backgroundColor: kGreenColor,
      duration: const Duration(seconds: 2),
    ));
  }
}
