import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  static const baseUrl = 'http://10.0.2.2:8080/api/products';

  // ✅ মূল মেথড
  static Future<List<Product>> fetchProducts() async {
    final resp = await http.get(Uri.parse(baseUrl));
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => Product.fromJson(e)).toList();
    }
    throw Exception('Failed to load products');
  }

  // ✅ alias method (সমাধানের জন্য)
  static Future<List<Product>> getProducts() async {
    return await fetchProducts();
  }

  // ✅ নতুন প্রোডাক্ট তৈরি
  static Future<Product> createProduct(Product product, File? imageFile) async {
    final request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.fields['product'] = jsonEncode({
      'name': product.name,
      'description': product.description,
      'price': product.price,
      'stock': product.stock,
      'discount': product.discount,
      'category': product.categoryId != null ? {'id': product.categoryId} : null,
      'subCategory': product.subCategoryId != null ? {'id': product.subCategoryId} : null,
    });
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
    }
    final streamed = await request.send();
    final resp = await http.Response.fromStream(streamed);
    if (resp.statusCode == 200) return Product.fromJson(jsonDecode(resp.body));
    throw Exception('Create failed: ${resp.body}');
  }

  // ✅ প্রোডাক্ট আপডেট
  static Future<Product> updateProduct(int id, Product p) async {
    final resp = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': p.name,
        'description': p.description,
        'price': p.price,
        'stock': p.stock,
        'discount': p.discount,
        'category': p.categoryId != null ? {'id': p.categoryId} : null,
        'subCategory': p.subCategoryId != null ? {'id': p.subCategoryId} : null,
        'pictureUrl': p.pictureUrl,
      }),
    );
    if (resp.statusCode == 200) return Product.fromJson(jsonDecode(resp.body));
    throw Exception('Update failed');
  }

  // ✅ প্রোডাক্ট ডিলিট
  static Future<void> deleteProduct(int id) async {
    final resp = await http.delete(Uri.parse('$baseUrl/$id'));
    if (resp.statusCode != 204) throw Exception('Delete failed');
  }
}
