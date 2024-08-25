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
  final scrollController = ScrollController();
  bool isScrollToTopBtnVisible = false;

  Future<void> scrollToTop() async {
    await scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      isScrollToTopBtnVisible = false;
    });
  }

  Future<void> scrollListener() async {
    if (scrollController.position.pixels >= 200 &&
        isScrollToTopBtnVisible != true) {
      setState(() {
        isScrollToTopBtnVisible = true;
      });
    }
    if (scrollController.position.pixels < 200 &&
        isScrollToTopBtnVisible == true) {
      setState(() {
        isScrollToTopBtnVisible = false;
      });
    }
  }

  @override
  void initState() {
    Get.put(RoverController());
    scrollController.addListener(scrollListener);

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<RoverController>();
    scrollController.dispose();
    scrollController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlackColor,
      floatingActionButton: isScrollToTopBtnVisible
          ? FloatingActionButton(
              onPressed: scrollToTop,
              backgroundColor: kRedColor,
              enableFeedback: true,
              mouseCursor: SystemMouseCursors.click,
              tooltip: "Scroll to top",
              hoverColor: kRedColor,
              hoverElevation: 50.0,
              child: const Icon(Icons.arrow_drop_up_rounded,
                  size: 40, color: kWhiteColor),
            )
          : const SizedBox(),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: GetBuilder<RoverController>(
            initState: (state) =>
                RoverController.instance.fetchRover(widget.sol, null),
            builder: (controller) {
              return ListView(
                controller: scrollController,
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
                    margin: const EdgeInsets.symmetric(
                        horizontal: kDefaultSpace * 2),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(kDefaultSpace))),
                    child: Builder(
                      builder: (context) {
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
              );
            }),
      ),
    );
  }
}
