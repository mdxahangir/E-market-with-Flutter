// import 'cart_item.dart';

// class CartSummary {
//   final List<CartItem> items;
//   final double totalSubtotal;
//   final double totalTax;
//   final double totalDiscount;
//   final double totalShipping;
//   final double grandTotal;

//   CartSummary({
//     required this.items,
//     required this.totalSubtotal,
//     required this.totalTax,
//     required this.totalDiscount,
//     required this.totalShipping,
//     required this.grandTotal,
//   });

//   factory CartSummary.fromJson(Map<String, dynamic> json) {
//     var itemList = (json['items'] as List)
//         .map((item) => CartItem.fromJson(item))
//         .toList();

//     return CartSummary(
//       items: itemList,
//       totalSubtotal: (json['totalSubtotal'] as num).toDouble(),
//       totalTax: (json['totalTax'] as num).toDouble(),
//       totalDiscount: (json['totalDiscount'] as num).toDouble(),
//       totalShipping: (json['totalShipping'] as num).toDouble(),
//       grandTotal: (json['grandTotal'] as num).toDouble(),
//     );
//   }
// }
