import 'package:flutter/material.dart';
import 'package:mars_rover/src/constant.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kDefaultSpace)),
          elevation: kDefaultSpace,
          child: const Image(
            image: AssetImage('assets/images/placeholder_image.png'),
            height: 100,
            width: 100,
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        kSizedBox,
        const Text(
          'Nothing here try filtering',
          style: TextStyle(
              color: kWhiteColor, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
