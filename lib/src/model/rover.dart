import 'package:mars_rover/src/model/camera.dart';

class RoverImage {
  final int id;
  final int sol;
  final Camera camera;
  final String imgSrc;
  final String earthDate;
  final Rover rover;

  RoverImage({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
    required this.rover,
  });

  factory RoverImage.fromJson(Map<String, dynamic> json) {
    return RoverImage(
      id: json['id'],
      sol: json['sol'],
      camera: Camera.fromJson(json['camera']),
      imgSrc: json['img_src'],
      earthDate: json['earth_date'],
      rover: Rover.fromJson(json['rover']),
    );
  }
}

class Rover {
  final int id;
  final String name;
  final String landingDate;
  final String launchDate;
  final String status;
  final int maxSol;
  final String maxDate;
  final int totalPhotos;
  final List<Camera> cameras;

  Rover({
    required this.id,
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
    required this.cameras,
  });

  factory Rover.fromJson(Map<String, dynamic> json) {
    var cameraList = json['cameras'] as List;
    List<Camera> cameras = cameraList.map((i) => Camera.fromJson(i)).toList();

    return Rover(
      id: json['id'],
      name: json['name'],
      landingDate: json['landing_date'],
      launchDate: json['launch_date'],
      status: json['status'],
      maxSol: json['max_sol'],
      maxDate: json['max_date'],
      totalPhotos: json['total_photos'],
      cameras: cameras,
    );
  }
}
