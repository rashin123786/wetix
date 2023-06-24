import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wetix/controller/provider/cart_services.dart';
import 'package:wetix/utils/constants/constants.dart';
import 'package:wetix/view/widgets/common_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Cart'),
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
                          final data = cartResponse.carts[index];

                          return ListTile(
                            title: Text(data.items.name),
                            subtitle: Text("${data.items.price}"),
                            trailing: AddTocartWidget(
                                cartId: data.id,
                                eventId: data.event,
                                count: data.items.quantity),
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
            title: Text("Total: ${value.totalamount}"),
            trailing: SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
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
}
