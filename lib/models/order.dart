class Order {
  final String id;
  final DateTime date;
  final double total;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "date": date.toIso8601String(),
      "total": total,
      "items": items.map((e) => e.toJson()).toList(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      date: DateTime.parse(json["date"]),
      total: json["total"],
      items: (json["items"] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final String title;
  final int quantity;
  final double price;

  OrderItem({
    required this.title,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    "title": title,
    "quantity": quantity,
    "price": price,
  };

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      title: json["title"],
      quantity: json["quantity"],
      price: json["price"],
    );
  }
}
