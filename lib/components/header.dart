import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mars_rover/src/constant.dart';

class HeaderSection extends StatelessWidget {
  final bool back;
  final int? sol;
  const HeaderSection({super.key, this.back = false, this.sol});

  void goBack() {
    Get.back();
  }

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
          child: Center(
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/nasa1.png'),
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
                kSizedBox,
                Text(
                  'Mars Rover - ${sol == null ? "Photos" : "Sol: $sol"}',
                  style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
        back
            ? Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                    onPressed: goBack,
                    icon: const Icon(
                      Icons.arrow_back,
                      color: kWhiteColor,
                      size: 30,
                    )))
            : const SizedBox()
      ],
    );
  }
}
