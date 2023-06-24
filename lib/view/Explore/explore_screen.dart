import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wetix/controller/services/home_page_service.dart';
import 'package:wetix/view/widgets/HomeWidget/home_widget.dart';
import 'package:wetix/view/widgets/exploreWidget/explore_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    HomeScreenServices homeScreenServices = HomeScreenServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LOGO',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(139, 87, 92, 1),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SvgPicture.asset(
                  'assets/images/shape.svg',
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: height * 0.1,
                child: ExploreSlider(width: width, height: height)),
            SizedBox(
              height: height * 0.1,
              child: ExploreSlider(width: width, height: height),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Trending Events',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            UpcomingWidget(
              width: width,
              height: height,
              isUpcoming: false,
              ispastEvent: false,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Upcoming Event',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder(
              future: homeScreenServices.getUpcomingEvent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!.isEmpty
                      ? const Center(child: Text('No Events'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data![index];
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 5),
                              child: Container(
                                width: double.infinity,
                                height: height * 0.28,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/rectangle.jpg'),
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 8),
                                          child: Text(
                                            "₹ ${data.price}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, top: 8),
                                          child: Text(
                                            data.eventCategory,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            data.event,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Text(
                    "Something wrong",
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return const Text(
                    "Something wrong",
                    style: TextStyle(color: Colors.white),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}




//  Stack(
//               children: [
//                 InkWell(
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => EticketScreen(),
//                       )),
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: height * 0.28,
//                     child: Image.asset(
//                       'assets/images/rectangle.jpg',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: width * 0.05,
//                   top: height * 0.15,
                //   child: Text(
                //     "\$320",
                //     style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w400),
                //   ),
                // ),
//                 Positioned(
//                   left: width * 0.05,
//                   top: height * 0.19,
                  // child: Text(
                  //   "Music concert",
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     color: Colors.white,
                  //   ),
                  // ),
//                 ),
//                 Positioned(
//                   left: width * 0.05,
//                   top: height * 0.21,
                  // child: Text(
                  //   "Soundrenaline",
                  //   style: TextStyle(
                  //       fontSize: 20,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w400),
                  // ),
//                 ),
//               ],
//             ),