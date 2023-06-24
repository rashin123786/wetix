import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wetix/controller/provider/cart_services.dart';
import 'package:wetix/utils/constants/constants.dart';

class AddTocartWidget extends StatefulWidget {
  AddTocartWidget(
      {super.key,
      required this.count,
      required this.eventId,
      required this.cartId});
  int count;
  final String eventId;
  final String cartId;

  @override
  State<AddTocartWidget> createState() => _AddTocartWidgetState();
}

class _AddTocartWidgetState extends State<AddTocartWidget> {
  @override
  Widget build(BuildContext context) {
    final cartprovider = Provider.of<cartController>(context, listen: false);

    return Container(
      width: 120,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(139, 87, 92, 1)),
          //  color: Color.fromRGBO(139, 87, 92, 1),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              if (widget.count == 1) {
                await cartprovider.deletCarts(specificUserId!, widget.cartId);
                Fluttertoast.showToast(
                    msg: "Item deleted from cart",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.brown,
                    textColor: Colors.white,
                    fontSize: 16.0);
              } else {
                // widget.count--;
                await cartprovider.updateCartItems(widget.count, widget.cartId,
                    specificUserId!, widget.eventId, '-');
              }
            },
            child: const Icon(
              Icons.remove,
              size: 18,
            ),
          ),
          Text('${widget.count}'),
          InkWell(
            onTap: () async {
              // widget.count++;
              await cartprovider.updateCartItems(widget.count, widget.cartId,
                  specificUserId!, widget.eventId, '+');
            },
            child: const Icon(
              Icons.add,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
