import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mars_rover/components/header.dart';
import 'package:mars_rover/components/loading_indicator.dart';
import 'package:mars_rover/components/sol_card.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/sol.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Get.put(SolController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SolController>();
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

                  return ListView.separated(
                    separatorBuilder: (context, index) => kSizedBox,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.solData.value!.photos.length,
                    itemBuilder: (context, index) {
                      return SolCard(
                        photo: controller.solData.value!.photos[index],
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
