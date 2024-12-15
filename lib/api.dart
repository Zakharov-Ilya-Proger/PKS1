import 'package:dio/dio.dart';

import 'models/AnalysisItem.dart';

class ApiService {
  final Dio _dio = Dio();

  // Измените базовый URL на новый сервер
  final String baseUrl = 'http://new-server-address';

  Future<List<Analyze>> getProducts() async {
    try {
      final response = await _dio.get('$baseUrl/analyzes/');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Analyze> products = data.map((product) => Analyze.fromJson(product)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e'); // Логирование ошибки
      throw Exception('Error fetching products: $e');
    }
  }

  Future<Analyze> getProduct(int ID) async {
    try {
      final response = await _dio.get('$baseUrl/analyzes/$ID');
      if (response.statusCode == 200) {
        return Analyze.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Failed to load data: $e'); // Логирование ошибки
      throw Exception('Failed to load data: $e');
    }
  }

  Future<void> addProductToServer(Analyze newProduct) async {
    try {
      final response = await _dio.post('$baseUrl/cart/post', data: {
        'id': newProduct.id,
        'title': newProduct.title,
        'cost': newProduct.cost,
        'days': newProduct.days,
      });
      if (response.statusCode == 200) {
        print('Product added successfully');
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      print('Error adding product: $e');
      throw Exception('Error adding product: $e');
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('$baseUrl/analyzes/delete/$id');
      if (response.statusCode == 200) {
        print('Product deleted successfully');
      } else {
        throw Exception('Failed to delete product');
      }
    } catch (e) {
      print('Error deleting product: $e');
      throw Exception('Error deleting product: $e');
    }
  }

  Future<void> updateProduct(Analyze item) async {
    try {
      final response = await _dio.put('$baseUrl/analyzes/update/${item.id}', data: {
        'id': item.id,
        'title': item.title,
        'cost': item.cost,
        'days': item.days,
      });
      if (response.statusCode == 200) {
        print('Product updated successfully');
      } else {
        throw Exception('Failed to update product');
      }
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Error updating product: $e');
    }
  }

  Future<void> addToFavorites(int analyzeId) async {
    try {
      final response = await _dio.post('$baseUrl/favorite/add/$analyzeId', options: Options(headers: {
        'Authorization': 'Bearer your_token_here', // Замените на ваш токен
      }));
      if (response.statusCode == 200) {
        print('Added to favorites successfully');
      } else {
        throw Exception('Failed to add to favorites');
      }
    } catch (e) {
      print('Error adding to favorites: $e');
      throw Exception('Error adding to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(int analyzeId) async {
    try {
      final response = await _dio.delete('$baseUrl/favorite/delete/$analyzeId', options: Options(headers: {
        'Authorization': 'Bearer your_token_here', // Замените на ваш токен
      }));
      if (response.statusCode == 200) {
        print('Removed from favorites successfully');
      } else {
        throw Exception('Failed to remove from favorites');
      }
    } catch (e) {
      print('Error removing from favorites: $e');
      throw Exception('Error removing from favorites: $e');
    }
  }

  Future<List<Analyze>> getFavorites() async {
    try {
      final response = await _dio.get('$baseUrl/favorite/get');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Analyze> favorites = data.map((item) => Analyze.fromJson(item)).toList();
        return favorites;
      } else {
        throw Exception('Failed to load favorites');
      }
    } catch (e) {
      print('Error fetching favorites: $e'); // Логирование ошибки
      throw Exception('Error fetching favorites: $e');
    }
  }
}
