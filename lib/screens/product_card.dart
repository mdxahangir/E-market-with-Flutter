// import 'package:e_market/screens/product_detail_screen.dart';
// import 'package:flutter/material.dart';
// import '../models/product.dart';

// class ProductCard extends StatelessWidget {
//   final Product product;

//   const ProductCard({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Card(
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: InkWell(
//         onTap: () {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => ProductDetailScreen(product: product),
//     ),
//   );
// },

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product image
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                 child: product.imageUrl != null
//                     ? Image.network(
//                         product.imageUrl!,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                         errorBuilder: (context, error, stackTrace) =>
//                             const Center(child: Icon(Icons.broken_image)),
//                       )
//                     : const Center(child: Icon(Icons.image_not_supported)),
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product name
//                   Text(
//                     product.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
//                   ),

//                   const SizedBox(height: 4),

//                   // Price and Discount
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "\৳${product.price.toStringAsFixed(2)}",
//                         style: theme.textTheme.bodyMedium?.copyWith(color: Colors.green[700]),
//                       ),
//                       if (product.discount > 0)
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             "-${product.discount}%",
//                             style: const TextStyle(color: Colors.white, fontSize: 12),
//                           ),
//                         ),
//                     ],
//                   ),

//                   const SizedBox(height: 2),

//                   // Optional: Stock
//                   Text(
//                     'In Stock: ${product.stock}',
//                     style: theme.textTheme.bodySmall,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


