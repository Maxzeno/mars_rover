import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mars_rover/src/model/rover.dart';

class NasaApiService {
  final String _apiKey = 'S6UaKFgcelRT5fiowbLNkpHhXzmv2jxNCidr7rmL';

  Future<List<RoverImage>> fetchRover(String date, String cameraName) async {
    final response = await http.get(
      Uri.parse(
          'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&earth_date=$date&camera=$cameraName&api_key=$_apiKey'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['photos'];
      if (data.isNotEmpty) {
        return data.map((e) => RoverImage.fromJson(e)).toList();
      } else {
        throw Exception('No images found');
      }
    } else {
      throw Exception('Failed to load images');
    }
  }
}
