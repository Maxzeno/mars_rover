import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mars_rover/components/empty_card.dart';
import 'package:mars_rover/components/filter.dart';
import 'package:mars_rover/components/my_image.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/controller/rover.dart';
import 'package:mars_rover/src/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: ListView(
          shrinkWrap: true,
          children: [
            Stack(
              children: [
                Image(
                  image: const AssetImage('assets/images/backdrop.png'),
                  height: media.height * 0.4,
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
            ),
            const FilterScreen(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultSpace * 2),
              decoration: BoxDecoration(
                  border: Border.all(width: 0),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(kDefaultSpace))),
              child: GetBuilder<RoverController>(
                builder: (controller) {
                  if (controller.isLoad.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kWhiteColor,
                      ),
                    );
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
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kDefaultSpace)),
                        elevation: kDefaultSpace,
                        child: Column(
                          children: [
                            MyImage(
                              url: controller.roverData[index].imgSrc,
                              height: media.height * 0.3,
                              radiusTop: kDefaultSpace,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(kDefaultSpace),
                              child: Column(
                                children: [
                                  Text(
                                    'Camera: ${controller.roverData[index].camera.fullName}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                      'Date: ${dataParseFormater(controller.roverData[index].earthDate)}'),
                                ],
                              ),
                            )
                          ],
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
