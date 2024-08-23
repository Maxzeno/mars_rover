import 'package:flutter/material.dart';
import 'package:mars_rover/components/my_image.dart';
import 'package:mars_rover/src/constant.dart';
import 'package:mars_rover/src/fetch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlackColor,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
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
                  bottom: 50,
                  left: (media.width * 0.5) - 50,
                  child: const Image(
                    image: AssetImage('assets/images/nasa1.png'),
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: kDefaultSpace * 2),
              decoration: BoxDecoration(
                  border: Border.all(width: 0),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(kDefaultSpace))),
              child: FutureBuilder(
                future: NasaApiService().fetchRover('', 'fhaz'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kRedColor,
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => kSizedBox,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(kDefaultSpace)),
                        elevation: kDefaultSpace,
                        child: Column(
                          children: [
                            MyImage(
                              url: snapshot.data![index].imgSrc,
                              height: media.height * 0.3,
                              radiusTop: kDefaultSpace,
                            ),
                            Text(
                                'Camera: ${snapshot.data![index].camera.fullName}'),
                            Text('Date: ${snapshot.data![index].earthDate}'),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
