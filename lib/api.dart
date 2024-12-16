import 'package:dio/dio.dart';
import 'auth/auth_service.dart';
import 'models/AnalysisItem.dart';
import 'models/BasketItem.dart';
import 'models/CatrHistoryItem.dart';

class ApiService {
  final Dio _dio = Dio();

  final authService = AuthService();

  final String baseUrl = 'http://10.0.2.2:8000';

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
      print('Error fetching products: $e');
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
      print('Failed to load data: $e');
      throw Exception('Failed to load data: $e');
    }
  }

  Future<void> addProductToServer(Analyze newProduct) async {
    try {
      final response = await _dio.post('$baseUrl/analyzes/add', data: {
        'title': newProduct.title,
        'cost': newProduct.cost,
        'days': newProduct.days,
        'type': newProduct.type,
      }, options: Options(headers: {
        'authorization': authService.getCurrentUserid(),
      }));
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
      final response = await _dio.delete('$baseUrl/analyzes/delete/$id', options: Options(headers: {
        'authorization': authService.getCurrentUserid(),
      }));
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
      final response = await _dio.put('$baseUrl/analyzes/update', data: {
        'id': item.id,
        'title': item.title,
        'cost': item.cost,
        'days': item.days,
        'type': item.type
      }, options: Options(headers: {
        'authorization': authService.getCurrentUserid(),
      }));
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
        'authorization': authService.getCurrentUserid(),
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
        'Authorization': authService.getCurrentUserid(),
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
      final response = await _dio.get('$baseUrl/favorite/get', options: Options(headers: {
        'authorization': authService.getCurrentUserid(),
      }));

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<Analyze> favorites = data.map((item) => Analyze.fromJson(item)).toList();
        return favorites;
      } else if (response.statusCode == 404) {
        throw Exception('404');
      } else {
        throw Exception('500');
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      throw Exception('Error fetching favorites: $e');
    }
  }
  Future<void> postToUserCart(List<CartItem> cart) async {
    try {
      final List<Map<String, dynamic>> cartData = cart.map((item) =>
      {
        'analyze_id': item.item.id,
        'count': item.count,
      }).toList();

      final response = await _dio.post('$baseUrl/cart/post', data:
        cartData, options: Options(headers: {
        'authorization': authService.getCurrentUserid(),
      }));

      if (response.statusCode == 200) {
        print('Cart posted successfully');
      } else {
        throw Exception('Failed to post cart');
      }
    } catch (e) {
      print('Error posting cart: $e');
      throw Exception('Error posting cart: $e');
    }
  }
  Future<List<CartHistoryItem>> getCartHistory() async {
    try {
      final response = await _dio.get('$baseUrl/cart/history', options: Options(headers: {
        'authorization': authService.getCurrentUserid(),
      }));
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CartHistoryItem.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load cart history');
      }
    } catch (e) {
      print('Error fetching cart history: $e');
      throw Exception('Error fetching cart history: $e');
    }
  }
}
