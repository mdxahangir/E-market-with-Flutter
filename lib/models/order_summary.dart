class OrderSummary {
  int? id;
  int userId;
  int addressId;
  int productId; 
  String? name;  
  int? quantity; 
  double grandTotal;
  DateTime? orderDate; 

  OrderSummary({
    this.id,
    required this.userId,
    required this.addressId,
    required this.productId,
    this.name,
    this.quantity,
    required this.grandTotal,
    this.orderDate,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      id: json['id'],
      userId: json['userId'],
      addressId: json['addressId'],
      productId: json['productId'],
      name: json['name'],
      quantity: json['quantity'],
      grandTotal: (json['grandTotal'] as num).toDouble(),
      orderDate: json['orderDate'] != null ? DateTime.parse(json['orderDate']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'userId': userId,
        'addressId': addressId,
        'productId': productId,
        if (name != null) 'name': name,
        if (quantity != null) 'quantity': quantity,
        'grandTotal': grandTotal,
        if (orderDate != null) 'orderDate': orderDate!.toIso8601String(),
      };
}
