import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/snackbar_controller.dart';
import 'package:mars_rover/src/model/rover.dart';

class RoverController extends GetxController {
  static RoverController get instance {
    return Get.find<RoverController>();
  }

  var isLoad = false.obs;
  var roverData = <RoverImage>[].obs;

  Future fetchRover(int sol, String? cameraName) async {
    isLoad.value = true;
    roverData.value = [];
    update();
    String url = '';

    if (cameraName == null) {
      url =
          'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=$sol&api_key=$apiKey&page=1';
    } else {
      url =
          'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=$sol&camera=$cameraName&api_key=$apiKey&page=1';
    }

    debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['photos'];
      roverData.value += data.map((e) => RoverImage.fromJson(e)).toList();
    } else {
      MySnackbarController.errorSnack('Failed to fetch');
    }
    isLoad.value = false;
    update();
  }
}
