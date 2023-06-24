import 'package:flutter/material.dart';
import 'package:wetix/view/widgets/HomeWidget/home_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: height * 0.3,
                  child: const SliderHomeWidget(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              '123 Clouds Music ',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Event promotor ',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: width * 0.22,
                                child: const ListTile(
                                  title: Text('Saved'),
                                  subtitle:
                                      Text('37', textAlign: TextAlign.center),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.4,
                                child: const ListTile(
                                  title: Text('Created Events'),
                                  subtitle:
                                      Text('37', textAlign: TextAlign.center),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.27,
                                child: const ListTile(
                                  title: Text('Booking'),
                                  subtitle:
                                      Text('22', textAlign: TextAlign.center),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20,
                                left: width * 0.24,
                                right: width * 0.24),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => verficationScreen(),
                                  //     ));
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    minimumSize: const Size(10, 50),
                                    backgroundColor:
                                        const Color.fromRGBO(139, 87, 92, 1)),
                                child: const Text('Create Events'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 11, right: 11),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: width * 0.4,
                                        height: height * 0.2,
                                        // color: Colors.black,
                                        child: Image.asset(
                                          'assets/images/rectangle.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: width * 0.4,
                                        height: height * 0.2,
                                        // color: Colors.black,
                                        child: Image.asset(
                                          'assets/images/rectangle.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      width: width * 0.5,
                                      height: height * 0.3,
                                      //  color: Colors.black,
                                      child: Image.asset(
                                        'assets/images/rectangle.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: width * 0.38,
              right: width * 0.38,
              top: height * 0.25,
              child: SizedBox(
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/rectangle.jpg',

                    fit: BoxFit.fitWidth,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
