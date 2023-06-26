class Items {
  final String name;
  final double price;
  final int quantity;

  Items({required this.name, required this.price, required this.quantity});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
    );
  }
}

class Order {
  final Items items;
  final String id;
  final String userId;
  final String event;
  final String status;
  final double total;
  final String cartId;
  final int v;

  Order({
    required this.items,
    required this.id,
    required this.userId,
    required this.event,
    required this.status,
    required this.total,
    required this.cartId,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      items: Items.fromJson(json['items']),
      id: json['_id'],
      userId: json['userId'],
      event: json['event'],
      status: json['status'],
      total: json['total'].toDouble(),
      cartId: json['cartId'],
      v: json['__v'],
    );
  }
}
