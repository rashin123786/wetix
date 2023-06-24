import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
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
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 50),
              child: Text(
                'Your Booking',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    height: height * 0.25,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage('assets/images/rectangle.jpg'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      // color: Colors.amber,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "\$140",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "Music concert",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Soundernaline",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
