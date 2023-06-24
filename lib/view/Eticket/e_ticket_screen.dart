import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class EticketScreen extends StatelessWidget {
  const EticketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Your E-Ticket',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 10, left: width * 0.1, right: width * 0.1),
                child: Container(
                  width: double.infinity,
                  height: height * 0.6,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(234, 234, 234, 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.28, top: height * 0.008),
                        child: Image.asset(
                          'assets/images/qrcode1.png',
                          width: 90,
                          height: 90,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8, right: 8),
                        child: ListTile(
                          title: Text(
                            'DJ Maksmellow Orginawa',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            'Orginawa',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.1,
                        // decoration: BoxDecoration(color: Colors.amber),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: width * 0.35,
                              height: height * 0.1,
                              //   decoration: BoxDecoration(color: Colors.white),
                              child: const ListTile(
                                title: Text(
                                  'Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '14 February 2021',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.35,
                              height: height * 0.1,
                              //  decoration: BoxDecoration(color: Colors.white),
                              child: const ListTile(
                                title: Text(
                                  'Time',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('12:30 Pm'),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        //  decoration: BoxDecoration(color: Colors.amber),
                        width: double.infinity,
                        height: height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: width * 0.4,
                              height: height * 0.1,
                              //   decoration: BoxDecoration(color: Colors.white),
                              child: const ListTile(
                                title: Text(
                                  'Check in Type ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'VIP A',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.35,
                              height: height * 0.1,
                              //  decoration: BoxDecoration(color: Colors.white),
                              child: const ListTile(
                                title: Text(
                                  'Order ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text('EBP12469'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: SizedBox(
                          width: width * 0.35,
                          height: height * 0.08,
                          //  decoration: BoxDecoration(color: Colors.white),
                          child: const ListTile(
                            title: Text(
                              'Place',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text('Surat gujarat'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: height * 0.16,
                left: width * 0.05,
                right: width * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                    DottedLine(
                      direction: Axis.horizontal,
                      lineLength: width * 0.6,
                      lineThickness: 1.0,
                      dashLength: 5.0,
                      dashColor: Colors.grey,
                      dashGapLength: 4.0,
                      dashGapColor: Colors.transparent,
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   top: height * 0.25,
              //   left: width * 0.1,
              //   right: width * 0.1,
              //   child:
              // ),
              // Positioned(
              //   top: height * 0.35,
              //   left: width * 0.1,
              //   right: width * 0.1,
              //   child:
              // ),
              // Positioned(
              //   top: height * 0.42,
              //   left: width * 0.1,
              //   right: width * 0.1,
              //   child:
              // ),
              // Positioned(
              //   top: height * 0.5,
              //   left: width * 0.12,
              //   right: width * 0.1,
              //   child:
              // ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: height * 0.23,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          color: Color.fromRGBO(234, 234, 234, 1),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Image.asset(
                  'assets/images/rectangle.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              title: const Text('Angela Ricardo'),
              subtitle: const Text('EVTY2145654354'),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.05, left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(20, 50),
                      backgroundColor: const Color.fromRGBO(139, 87, 92, 1)),
                  child: const Text('Sign In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
