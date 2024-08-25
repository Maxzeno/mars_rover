class Sol {
  final String name;
  final String landingDate;
  final String launchDate;
  final String status;
  final int maxSol;
  final String maxDate;
  final int totalPhotos;
  final List<Photos> photos;

  Sol({
    required this.name,
    required this.landingDate,
    required this.launchDate,
    required this.status,
    required this.maxSol,
    required this.maxDate,
    required this.totalPhotos,
    required this.photos,
  });

  factory Sol.fromJson(Map<String, dynamic> json) {
    var photoList = json['photos'] as List;
    List<Photos> photos = photoList.map((i) => Photos.fromJson(i)).toList();

    return Sol(
      name: json['name'],
      landingDate: json['landing_date'],
      launchDate: json['launch_date'],
      status: json['status'],
      maxSol: json['max_sol'],
      maxDate: json['max_date'],
      totalPhotos: json['total_photos'],
      photos: photos,
    );
  }
}

class Photos {
  final int sol;
  final int totalPhotos;
  final List<dynamic> cameras;
  final String earthDate;

  Photos({
    required this.sol,
    required this.totalPhotos,
    required this.cameras,
    required this.earthDate,
  });

  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      sol: json['sol'],
      totalPhotos: json['total_photos'],
      cameras: json['cameras'],
      earthDate: json['earth_date'],
    );
  }
}
