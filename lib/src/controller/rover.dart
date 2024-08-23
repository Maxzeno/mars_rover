import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/model/rover.dart';

class RoverController extends GetxController {
  static RoverController get instance {
    return Get.find<RoverController>();
  }

  var isLoad = false.obs;
  var roverData = <RoverImage>[].obs;

  Future fetchRover(String date, String cameraName) async {
    isLoad.value = true;
    roverData.value = [];
    update();

    final response = await http.get(
      Uri.parse(
          'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&earth_date=$date&camera=$cameraName&api_key=$apiKey'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['photos'];
      roverData.value = data.map((e) => RoverImage.fromJson(e)).toList();
    } else {
      // pop up something
    }
    isLoad.value = false;
    update();
  }
}
