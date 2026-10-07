class OrderItem {
  final int? id;
  final int productId;
  final String productName;
  final String? productImage;
  final double price;
  final int quantity;

  OrderItem({
    this.id,
    required this.productId,
    required this.productName,
    this.productImage,
    required this.price,
    required this.quantity,
  });

  double get subtotal => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'product_name': productName,
      'product_image': productImage,
      'price': price,
      'quantity': quantity,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      productId: json['product_id'] ?? 0,
      productName: json['product_name'] ?? '',
      productImage: json['product_image'],
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }
}

class Order {
  final int? id;
  final String? orderNumber;
  final double total;
  final double shippingCost;
  final double tax;
  final double subtotal;
  final String status;
  final String paymentMethod;
  final String shippingAddress;
  final String? note;
  final DateTime? createdAt;
  final List<OrderItem> items;

  Order({
    this.id,
    this.orderNumber,
    required this.total,
    this.shippingCost = 0,
    this.tax = 0,
    this.subtotal = 0,
    this.status = 'pending',
    this.paymentMethod = 'cash_on_delivery',
    this.shippingAddress = '',
    this.note,
    this.createdAt,
    this.items = const [],
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderItem> items = [];
    if (json['items'] != null && json['items'] is List) {
      items = (json['items'] as List)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      total: (json['total'] ?? 0).toDouble(),
      shippingCost: (json['shipping_cost'] ?? 0).toDouble(),
      tax: (json['tax'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      status: json['status'] ?? 'pending',
      paymentMethod: json['payment_method'] ?? 'cash_on_delivery',
      shippingAddress: json['shipping_address'] ?? '',
      note: json['note'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      items: items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'shipping_cost': shippingCost,
      'tax': tax,
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress,
      'note': note,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
