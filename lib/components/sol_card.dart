import 'package:flutter/material.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/model/sol.dart';
import 'package:mars_rover/src/utils.dart';

class SolCard extends StatelessWidget {
  final Photos photo;
  const SolCard({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhiteColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultSpace)),
      elevation: kDefaultSpace,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(kDefaultSpace),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sol: ${photo.sol}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    Text('Date: ${dataParseFormater(photo.earthDate)}'),
                  ],
                ),
                kSizedBox,
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        'Cameras: ${photo.cameras}',
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
