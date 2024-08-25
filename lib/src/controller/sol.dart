import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/snackbar_controller.dart';
import 'package:mars_rover/src/model/sol.dart';

class SolController extends GetxController {
  static SolController get instance {
    return Get.find<SolController>();
  }

  var retry = false.obs;
  var isLoad = false.obs;
  var isLoadMore = false.obs;
  var solData = Rxn<Sol>();
  var photos = <Photos>[].obs;
  var index = 0;
  var length = 10;

  Future fetchSol() async {
    retry.value = false;
    isLoad.value = true;
    solData.value = null;
    update();

    String url =
        'https://api.nasa.gov/mars-photos/api/v1/manifests/curiosity?api_key=$apiKey';

    debugPrint(url);
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body)['photo_manifest'];
      solData.value = Sol.fromJson(data);
      photos.addAll(solData.value!.photos.sublist(index, length + index));
      index = length;
    } else {
      retry.value = true;
      MySnackbarController.errorSnack('Failed to fetch');
    }
    isLoad.value = false;
    update();
  }

  Future showPhotos() async {
    isLoadMore.value = true;
    update();

    await Future.delayed(const Duration(seconds: 1));

    photos.addAll(solData.value!.photos.sublist(index, length + index));
    index = length;
    isLoadMore.value = false;
    update();
  }
}
