import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:wetix/model/cart_model.dart';
import 'package:wetix/model/order_history_model.dart';
import 'package:wetix/utils/constants/constants.dart';
import 'package:wetix/utils/url.dart';
import 'package:wetix/view/cart/cart_screen.dart';

// add to cart=================
class cartController with ChangeNotifier {
  void addToCarts(
      String userId, String eventId, Item items, double total) async {
    final headers = {
      "Authorization": token!,
      "Content-Type": "application/json"
    };
    log(userId);
    final body = jsonEncode({
      "userId": userId,
      "event": eventId,
      "item": {"name": items.name, "quantity": items.quantity}
    });

    final response =
        await http.post(Uri.parse(addToCart), body: body, headers: headers);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final results = await result['items'];
      log("$results");
      Fluttertoast.showToast(
          msg: "Event added to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Event is already added to cart",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.brown,
          textColor: Colors.white,
          fontSize: 16.0);
      log("${response.statusCode}");
    }
  }

// ==========get cart data===============
  double? totalamount;
  Future<CartModel> getCartItem() async {
    final url = "$getCartData$specificUserId";
    final headers = {
      "Authorization": token!,
      "Content-Type": "application/json"
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final result = CartModel.fromJson(jsonData);
      totalamount = result.totalSum;

      notifyListeners();
      return result;
    } else {
      if (response.statusCode == 404) {
        totalamount = 0;
      }
      log(response.statusCode.toString());
      notifyListeners();
      return CartModel(success: false, carts: [], totalSum: 0);
    }
  }

// update item quantity=========
  updateCartItems(int count, String cartId, String userId, String evenId,
      String action) async {
    print(cartId);
    print(evenId);
    print(token);

    final headers = {
      "Authorization": token!,
      "Content-Type": "application/json"
    };
    final body = jsonEncode({
      "cartId": cartId,
      "userId": userId,
      "event": evenId,
      "action": action
    });

    try {
      final response = await http.put(Uri.parse(updateItemQuantity),
          body: body, headers: headers);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final updatedCart = CartModel.fromJson(jsonData['cart']['items']);
        log("$updatedCart");
        notifyListeners();
        await getCartItem();
        notifyListeners();
      } else {
        print("failed ${response.body}");
        notifyListeners();
      }
    } catch (e) {
      log(e.toString());
      notifyListeners();
    }
  }

// Delete Cart ==============

  deletCarts(String userId, String cartId) async {
    final headers = {
      "Authorization": token!,
      "Content-Type": "application/json"
    };

    final response = await http.delete(Uri.parse("$deleteCart$userId/$cartId"),
        headers: headers);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
    } else {
      log(response.body.toString());
    }
  }

  // cartOrder==============

  createOrders(
      {required String userId,
      required List eventId,
      required List cartId}) async {
    print(" this is event id = ${eventId}");
    print(" this is  cart id  = ${cartId}");
    final headers = {
      "Authorization": token!,
      "Content-Type": "application/json"
    };
    String? body;

    log(eventId.length.toString());
    for (int i = 0; i <= eventId.length - 1; i++) {
      log(eventId[i], name: 'this is ifor');
      body = jsonEncode(
          {"userId": userId, "event": eventId[i], "cartId": cartId[i]});
      final response =
          await http.post(Uri.parse(cartOrder), headers: headers, body: body);
      if (response.statusCode == 201) {
        final result = jsonDecode(response.body);
        Fluttertoast.showToast(
            msg: "order placed successfuly",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.brown,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        log(response.body);
        Fluttertoast.showToast(
            msg: "please try again",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.brown,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }
}

Future<List<Order>> getCartOrderData() async {
  final headers = {"Authorization": token!, "Content-Type": "application/json"};
  final response = await http
      .get(Uri.parse("${getCartOrder + specificUserId!}"), headers: headers);
  if (response.statusCode == 200) {
    final result = jsonDecode(response.body);
    List<Order> orderList = [];
    for (var orderJson in result['orders']) {
      Order order = Order.fromJson(orderJson);
      orderList.add(order);
    }
    log(orderList.length.toString());
    return orderList;
  } else {
    return [];
  }
}
