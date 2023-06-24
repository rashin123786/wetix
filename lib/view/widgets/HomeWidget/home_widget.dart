import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:wetix/controller/services/home_page_service.dart';
import 'package:wetix/model/event_model.dart';
import 'package:wetix/utils/constants/constants.dart';
import 'package:wetix/utils/url.dart';
import 'package:wetix/view/EventDetails/event_details_screen.dart';

//===========First Slider======================>

class SliderHomeWidget extends StatefulWidget {
  const SliderHomeWidget({super.key});

  @override
  State<SliderHomeWidget> createState() => _SliderHomeWidgetState();
}

int _current = 0;
PageController controllerPage = PageController(initialPage: 0);
final CarouselController controller = CarouselController();

class _SliderHomeWidgetState extends State<SliderHomeWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Stack(
      children: [
        PageView.builder(
          itemCount: sliderImg.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final sliderImgData = sliderImg[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(sliderImgData),
              )),
            );
          },
          controller: controllerPage,
          onPageChanged: (value) {
            setState(() {
              _current = value;
            });
          },
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          height: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
                sliderImg.length,
                (index) => InkWell(
                      onTap: () {
                        controllerPage.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor:
                            _current == index ? Colors.brown : Colors.white,
                      ),
                    )),
          ),
        )
      ],
    );
  }
}

//==============Upcoming events  ============>

class UpcomingWidget extends StatelessWidget {
  const UpcomingWidget({
    super.key,
    required this.width,
    required this.height,
    required this.isUpcoming,
    required this.ispastEvent,
  });

  final double width;
  final double height;
  final bool isUpcoming;
  final bool ispastEvent;

  @override
  Widget build(BuildContext context) {
    HomeScreenServices homeScreenServices = HomeScreenServices();
    return SizedBox(
      width: double.infinity,
      height: height * 0.28,
      child: FutureBuilder(
        future: isUpcoming == true
            ? ispastEvent == true
                ? homeScreenServices.getPastEvent()
                : homeScreenServices.getUpcomingEvent()
            : ispastEvent == true
                ? homeScreenServices.getPastEvent()
                : homeScreenServices.getLiveEvent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? const Center(child: Text('No Events'))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final data = snapshot.data![index];
                      userObjectId = data.userId;
                      // final img
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: InkWell(
                            onTap: () {
                              EventModel eventModel = EventModel(
                                  id: data.id,
                                  userId: data.userId,
                                  event: data.event,
                                  organization: data.organization,
                                  eventCategory: data.eventCategory,
                                  imagePath: data.imagePath,
                                  startDate: data.startDate,
                                  endDate: data.endDate,
                                  place: data.place,
                                  price: data.price,
                                  note: data.note,
                                  status: data.status,
                                  isBooked: data.isBooked,
                                  eventMap: data.eventMap,
                                  feeOptions: data.feeOptions,
                                  isDelete: data.isDelete);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventDetails(eventModel: eventModel),
                                  ));
                            },
                            child: Container(
                              width: width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/images/rectangle.jpg'))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "₹ ${data.price}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 5),
                                      child: Text(
                                        data.eventCategory,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, top: 5),
                                      child: Text(
                                        data.event,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
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
    );
  }
}
