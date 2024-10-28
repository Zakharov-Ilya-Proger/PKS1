import 'package:dio/dio.dart';
import 'package:pks3/models/KvasItem.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<KvasItem>> getProducts() async {
    try {
      final response = await _dio.get('http://10.0.2.2:8000/products');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        List<KvasItem> products = data.map((product) => KvasItem.fromJson(product)).toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e'); // Логирование ошибки
      throw Exception('Error fetching products: $e');
    }
  }

  Future<KvasItem> getProduct(int ID) async {
    try {
      final response = await _dio.get('http://10.0.2.2:8000/products/$ID');
      if (response.statusCode == 200) {
        return KvasItem.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Failed to load data: $e'); // Логирование ошибки
      throw Exception('Failed to load data: $e');
    }
  }

  Future<void> addProductToServer(KvasItem newProduct) async {
    try {
      final response = await _dio.post('http://10.0.2.2:8000/products/create', data: {
        'id': newProduct.ID,
        'name': newProduct.name,
        'description': newProduct.description,
        'image_url': newProduct.imageUrl,
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

  Future<void> deliteKvas(int id) async{
    try{
      final response = await _dio.delete('http://10.0.2.2:8000/products/delete/$id');
      if (response.statusCode == 200){
        print('sosal? konechno!!');
      }else{
        throw Exception('Failed to delete kvas');
      }
    }catch(e){
      print('Error delete kvas $e');
      throw Exception('Error delete kvas $e');
    }
  }

  Future<void> updateKvas(KvasItem item) async {
    try {
      final response = await _dio.put('http://10.0.2.2:8000/products/update/${item.ID}', data: {
        'id': item.ID,
        'name': item.name,
        'description': item.description,
        'image_url': item.imageUrl,
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
}
