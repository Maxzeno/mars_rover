import 'package:flutter/material.dart';
import 'package:mars_rover/components/my_image.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/model/rover.dart';
import 'package:mars_rover/src/utils.dart';

class RoverCard extends StatelessWidget {
  final RoverImage rover;
  const RoverCard({super.key, required this.rover});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Card(
      color: kWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultSpace)),
      elevation: kDefaultSpace,
      child: Column(
        children: [
          MyImage(
            url: rover.imgSrc,
            height: media.height * 0.3,
            radiusTop: kDefaultSpace,
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultSpace),
            child: Column(
              children: [
                Text(
                  'Camera: ${rover.camera.fullName}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text('Date: ${dataParseFormater(rover.earthDate)}'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
