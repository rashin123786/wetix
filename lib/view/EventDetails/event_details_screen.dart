import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wetix/controller/provider/cart_services.dart';
import 'package:wetix/model/cart_model.dart';
import 'package:wetix/model/event_model.dart';
import 'package:wetix/utils/constants/constants.dart';
import 'package:wetix/utils/url.dart';
import 'package:wetix/view/widgets/HomeWidget/home_widget.dart';
import 'package:intl/intl.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key, required this.eventModel});
  final EventModel eventModel;

  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<cartController>(context);
    log("id is : $specificUserId");
    log("authtoken is : $token");
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    userObjectId = eventModel.userId;
    log(userObjectId.toString());
    String originalDate = '${eventModel.startDate}';
    DateTime parsedDate = DateTime.parse(originalDate);
    String formattedDate = DateFormat('EEEE, d MMMM yyyy').format(parsedDate);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.3,
                    child: const SliderHomeWidget(),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ))
                ],
              ),
              Container(
                width: double.infinity,
                height: height * 0.66,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(eventModel.eventCategory),
                      subtitle: Text(
                        eventModel.event,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    ListTile(
                      title: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: "₹ ${eventModel.price}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            )),
                        const TextSpan(
                            text: ' / person',
                            style: TextStyle(
                                color: Color.fromARGB(255, 91, 91, 91)))
                      ])),
                      trailing: const Text(
                        'Bills included',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        eventModel.organization,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.brown,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 91, 91, 91)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, top: 15),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.brown,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            eventModel.place,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 91, 91, 91)),
                          ),
                          const Spacer(),
                          const Text('Direction',
                              style: TextStyle(color: Colors.brown))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Event Details',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,'''),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
          child: ElevatedButton(
            onPressed: () {
              Item item = Item(
                  name: eventModel.event,
                  price: eventModel.price.toDouble(),
                  quantity: 1,
                  subtotal: eventModel.price.toDouble());
              log(item.name);
              log(item.price.toString());

              log("event details : ${eventModel.id}");
              cartprovider.addToCarts(specificUserId!, eventModel.id, item,
                  eventModel.price.toDouble());
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(20, 50),
                backgroundColor: const Color.fromRGBO(139, 87, 92, 1)),
            child: const Text('Buy Ticket'),
          ),
        ),
      ),
    );
  }
}
