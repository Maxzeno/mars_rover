import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mars_rover/components/empty_card.dart';
import 'package:mars_rover/components/filter.dart';
import 'package:mars_rover/components/header.dart';
import 'package:mars_rover/components/loading_indicator.dart';
import 'package:mars_rover/components/rover_card.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/rover.dart';

class RoverScreen extends StatefulWidget {
  final List<dynamic> cameraTypes;
  final int sol;
  const RoverScreen({super.key, required this.cameraTypes, required this.sol});

  @override
  State<RoverScreen> createState() => _RoverScreenState();
}

class _RoverScreenState extends State<RoverScreen> {
  @override
  void initState() {
    Get.put(RoverController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<RoverController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          shrinkWrap: true,
          children: [
            HeaderSection(
              sol: widget.sol,
              back: true,
            ),
            FilterScreen(
              cameraTypes: widget.cameraTypes,
              sol: widget.sol,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultSpace * 2),
              decoration: BoxDecoration(
                  border: Border.all(width: 0),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(kDefaultSpace))),
              child: GetBuilder<RoverController>(
                builder: (controller) {
                  if (controller.isLoad.value) {
                    return const LoadingIndicator();
                  }
                  if (controller.roverData.isEmpty) {
                    return const Center(
                      child: Column(
                        children: [
                          kSizedBox,
                          kSizedBox,
                          kSizedBox,
                          EmptyCard(),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => kSizedBox,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.roverData.length,
                    itemBuilder: (context, index) {
                      return RoverCard(
                        rover: controller.roverData[index],
                      );
                    },
                  );
                },
              ),
            ),
            kSizedBox
          ],
        ),
      ),
    );
  }
}
