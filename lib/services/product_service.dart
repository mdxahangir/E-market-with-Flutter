// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import '../models/product.dart';

// class ProductService {
//   static const baseUrl = 'http://localhost:8080/api/products';

//   static Future<Product> createProductMobile(Product product, File imageFile) async {
//     final uri = Uri.parse(baseUrl);
//     final request = http.MultipartRequest('POST', uri);
//     request.fields['product'] = jsonEncode(product.toJson());

//     request.files.add(await http.MultipartFile.fromPath(
//       'image',
//       imageFile.path,
//       contentType: MediaType('image', 'jpeg'),
//     ));

//     // Optional: Set headers (Content-Type is automatically set for multipart)
//     // request.headers['Content-Type'] = 'multipart/form-data';

//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final responseData = jsonDecode(response.body);
//       return Product.fromJson(responseData);
//     } else {
//       throw Exception('Failed to create product: ${response.body}');
//     }
//   }

//   //For Web
//   static Future<Product> createProductWeb(Product product, String fileName, Uint8List bytes) async {
//     final uri = Uri.parse(baseUrl);
//     final request = http.MultipartRequest('POST', uri);
//     request.fields['product'] = jsonEncode(product.toJson());
//     request.files.add(http.MultipartFile.fromBytes(
//       'image',
//       bytes,
//       filename: fileName,
//       contentType: MediaType('image', 'jpeg'),
//     ));

//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final responseData = jsonDecode(response.body);
//       return Product.fromJson(responseData);
//     } else {
//       throw Exception('Failed to create product (web): ${response.body}');
//     }
//   }

//   // Fetch All Products
//   static Future<List<Product>> getAllProducts() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       final List jsonData = jsonDecode(response.body);
//       return jsonData.map((e) => Product.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to fetch products');
//     }
//   }

//   // Delete Product
//   static Future<void> deleteProduct(int id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/$id'));
//     if (response.statusCode != 204) {
//       throw Exception('Failed to delete product: ${response.body}');
//     }
//   }
// }
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import '../models/product.dart';

// class ProductService {
//   static const baseUrl = 'http://localhost:8080/api/products';// Use 10.0.2.2 for Android emulator

//   static Future<Product> createProductMobile(Product product, File imageFile) async {
//     final uri = Uri.parse(baseUrl);
//     final request = http.MultipartRequest('POST', uri);

//     request.fields['product'] = jsonEncode(product.toJson());

//     request.files.add(await http.MultipartFile.fromPath(
//       'image', // 👈 This matches your backend field
//       imageFile.path,
//       contentType: MediaType('image', 'jpeg'),
//     ));

//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final responseData = jsonDecode(response.body);
//       return Product.fromJson(responseData);
//     } else {
//       throw Exception('Failed to create product: ${response.body}');
//     }
//   }

//   static Future<Product> createProductWeb(Product product, String fileName, Uint8List imageBytes) async {
//     final uri = Uri.parse('$baseUrl/web-upload'); // Adjust this endpoint if needed
//     final request = http.MultipartRequest('POST', uri);
//     request.fields['product'] = jsonEncode(product.toJson());

//     final multipartFile = http.MultipartFile.fromBytes(
//       'file', // 👈 this should match your backend field
//       imageBytes,
//       filename: fileName,
//       contentType: MediaType('image', 'jpeg'),
//     );
//     request.files.add(multipartFile);

//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final responseData = jsonDecode(response.body);
//       return Product.fromJson(responseData);
//     } else {
//       throw Exception('Failed to upload product (web): ${response.body}');
//     }
//   }

//   static Future<Product> createProduct(Product product) async {
//     final uri = Uri.parse(baseUrl);
//     final headers = {'Content-Type': 'application/json'};
//     final body = jsonEncode(product.toJson());

//     final response = await http.post(uri, headers: headers, body: body);

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final responseData = jsonDecode(response.body);
//       return Product.fromJson(responseData);
//     } else {
//       throw Exception('Failed to create product: ${response.body}');
//     }
//   }

//   static Future<List<Product>> getAllProducts() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       final List jsonData = jsonDecode(response.body);
//       return jsonData.map((e) => Product.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to fetch products');
//     }
//   }

//   static Future<void> deleteProduct(int id) async {
//     final response = await http.delete(Uri.parse('$baseUrl/$id'));
//     if (response.statusCode != 204) {
//       throw Exception('Failed to delete product: ${response.body}');
//     }
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../models/product.dart';

class ProductService {
  static const baseUrl = 'http://localhost:8080/api/products';

  static Future<Product> createProductMobile(Product product, File imageFile) async {
    final uri = Uri.parse(baseUrl);
    final request = http.MultipartRequest('POST', uri);
    request.fields['product'] = jsonEncode(product.toJson());

    request.files.add(await http.MultipartFile.fromPath(
      'image',
      imageFile.path,
      contentType: MediaType('image', 'jpeg'),
    ));

    // Optional: Set headers (Content-Type is automatically set for multipart)
    // request.headers['Content-Type'] = 'multipart/form-data';

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return Product.fromJson(responseData);
    } else {
      throw Exception('Failed to create product: ${response.body}');
    }
  }

  //For Web
  static Future<Product> createProductWeb(Product product, String fileName, Uint8List bytes) async {
    final uri = Uri.parse(baseUrl);
    final request = http.MultipartRequest('POST', uri);
    request.fields['product'] = jsonEncode(product.toJson());
    request.files.add(http.MultipartFile.fromBytes(
      'image',
      bytes,
      filename: fileName,
      contentType: MediaType('image', 'jpeg'),
    ));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      return Product.fromJson(responseData);
    } else {
      throw Exception('Failed to create product (web): ${response.body}');
    }
  }

  // Fetch All Products
  static Future<List<Product>> getAllProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  // Delete Product
  static Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete product: ${response.body}');
    }
  }
}