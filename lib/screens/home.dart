import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mars_rover/components/button.dart';
import 'package:mars_rover/components/header.dart';
import 'package:mars_rover/components/loading_indicator.dart';
import 'package:mars_rover/components/sol_card.dart';
import 'package:mars_rover/screens/rover.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/sol.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  bool isScrollToTopBtnVisible = false;
  Future<void> showMore() async {
    if (SolController.instance.photos.isEmpty) {
      return;
    }

    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      SolController.instance.showPhotos();
    }
  }

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
    Get.put(SolController());
    scrollController.addListener(showMore);
    scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SolController>();
    scrollController.dispose();
    scrollController.removeListener(() {});
    super.dispose();
  }

  void toRover(List<dynamic> cameraTypes, int sol) {
    Get.to(
      () => RoverScreen(
        cameraTypes: cameraTypes,
        sol: sol,
      ),
      routeName: 'RoverScreen',
      duration: const Duration(milliseconds: 300),
      fullscreenDialog: true,
      curve: Curves.easeIn,
      preventDuplicates: true,
      popGesture: true,
      transition: Transition.rightToLeft,
    );
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
                  size: 18, color: kWhiteColor),
            )
          : const SizedBox(),
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          shrinkWrap: true,
          children: [
            const HeaderSection(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultSpace * 2),
              decoration: BoxDecoration(
                  border: Border.all(width: 0),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(kDefaultSpace))),
              child: GetBuilder<SolController>(
                initState: (state) => SolController.instance.fetchSol(),
                builder: (controller) {
                  if (controller.isLoad.value) {
                    return const LoadingIndicator();
                  }

                  if (controller.retry.value) {
                    return MyButton(
                        onPressed: SolController.instance.fetchSol,
                        text: 'Retry');
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => kSizedBox,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.solData.value!.photos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          toRover(
                              controller.solData.value!.photos[index].cameras,
                              controller.solData.value!.photos[index].sol);
                        },
                        child: SolCard(
                          photo: controller.solData.value!.photos[index],
                        ),
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
