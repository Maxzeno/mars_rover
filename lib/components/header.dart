import 'package:flutter/material.dart';
import 'package:mars_rover/src/constant.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image(
          image: const AssetImage('assets/images/backdrop.png'),
          height: media.height * 0.4,
          width: media.width,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        Positioned(
          width: media.width,
          bottom: 10,
          child: const Center(
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/images/nasa1.png'),
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
                kSizedBox,
                Text(
                  'Mars Rover - Photos',
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
