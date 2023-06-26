import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wetix/controller/provider/cart_services.dart';
import 'package:wetix/model/cart_model.dart';
import 'package:wetix/utils/constants/constants.dart';
import 'package:wetix/view/widgets/bottom_nav.dart';
import 'package:wetix/view/widgets/common_widget.dart';

int? cartTotal;
String? hlo;
List<dynamic> eventIdList = [];
List<dynamic> cartIdList = [];

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Cart'),
          backgroundColor: const Color(0xFF8B575C)),
      body: SafeArea(
        child: Consumer<cartController>(
          builder: (context, value, child) => FutureBuilder(
            future: value.getCartItem(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final cartResponse = snapshot.data;

                return cartResponse!.carts.isEmpty
                    ? const Center(
                        child: Text('No Cart Item'),
                      )
                    : ListView.separated(
                        itemCount: cartResponse.carts.length,
                        itemBuilder: (context, index) {
                          cartTotal = cartResponse.carts.length;
                          //  print(cartResponse.carts[index].event);
                          final data = cartResponse.carts[index];
                          if (!eventIdList.contains(data.event)) {
                            eventIdList.add(data.event);
                          }
                          if (!cartIdList.contains(data.id)) {
                            cartIdList.add(data.id);
                          }

                          cart = Cart(
                              items: data.items,
                              id: data.id,
                              userId: data.userId,
                              event: data.event,
                              total: data.total,
                              tax: data.tax,
                              serviceCharge: data.serviceCharge,
                              v: data.v);

                          return GestureDetector(
                            onTap: () {
                              print(data.event);
                            },
                            child: ListTile(
                              title: Text(data.items.name),
                              subtitle: Text("₹${data.items.price}"),
                              trailing: AddTocartWidget(
                                  cartId: data.id,
                                  eventId: data.event,
                                  count: data.items.quantity),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<cartController>(
          builder: (context, value, child) => ListTile(
            title: Text("Total: ₹${value.totalamount}"),
            trailing: SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () async {
                  await showOrderConfirm(context);
                  //  print(cart!.event);

                  print(
                      "userId: ${cart!.userId} == eventId: ${cart!.event}===cartId:-${cart!.id}");
                },
                child: const Text('Buy'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(139, 87, 92, 1)),
              ),
            ),
          ),
        ),
        // child: SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton(
        //       onPressed: () {
        //         print(totalAmount);
        //       },
        //       child: Text('Buy')),
        // ),
      ),
    );
  }

  showOrderConfirm(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = Consumer<cartController>(
      builder: (context, value, child) => TextButton(
        child: Text("Continue"),
        onPressed: () async {
          await value.createOrders(
              userId: cart!.userId, eventId: eventIdList, cartId: cartIdList);
          cartIdList.clear();
          eventIdList.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Are you sure"),
      content: Text("Would you like to continue Buy"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
