class CartModel {
  bool success;
  List<Cart> carts;
  double totalSum;

  CartModel({
    required this.success,
    required this.carts,
    required this.totalSum,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      success: json['success'],
      carts: List<Cart>.from(json['carts'].map((cart) => Cart.fromJson(cart))),
      totalSum: json['totalSum'].toDouble(),
    );
  }
}

class Cart {
  Item items;
  String id;
  String userId;
  String event;
  double total;
  double tax;
  double serviceCharge;
  int v;

  Cart({
    required this.items,
    required this.id,
    required this.userId,
    required this.event,
    required this.total,
    required this.tax,
    required this.serviceCharge,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      items: Item.fromJson(json['items']),
      id: json['_id'],
      userId: json['userId'],
      event: json['event'],
      total: json['total'].toDouble(),
      tax: json['tax'].toDouble(),
      serviceCharge: json['serviceCharge'].toDouble(),
      v: json['__v'],
    );
  }
}

class Item {
  String name;
  double price;
  int quantity;
  double subtotal;

  Item({
    required this.name,
    required this.price,
    required this.quantity,
    required this.subtotal,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      subtotal: json['subtotal'].toDouble(),
    );
  }
}
