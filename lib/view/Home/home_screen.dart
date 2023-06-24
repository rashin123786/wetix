import 'package:flutter/material.dart';
import 'package:wetix/controller/services/home_page_service.dart';
import 'package:wetix/view/widgets/HomeWidget/home_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    HomeScreenServices hm = HomeScreenServices();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.3,
                child: const SliderHomeWidget(),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 50),
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              UpcomingWidget(
                width: width,
                height: height,
                isUpcoming: true,
                ispastEvent: false,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, top: 50),
                child: Text(
                  'Live Events',
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
                padding: EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  'Past Events',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              UpcomingWidget(
                width: width,
                height: height,
                isUpcoming: false,
                ispastEvent: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
