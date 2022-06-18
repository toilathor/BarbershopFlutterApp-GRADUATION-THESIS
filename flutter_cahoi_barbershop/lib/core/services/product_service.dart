import 'package:dio/dio.dart';
import 'package:flutter_cahoi_barbershop/core/apis/api.dart';
import 'package:flutter_cahoi_barbershop/core/models/product.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';

class ProductService {
  final _api = locator<Api>();

  Future<bool?> createProduct({required FormData data}) async {
    var res = await _api.createProduct(data: data);

    if (res != null) {
      return res.data;
    }
    return null;
  }

  Future<Product?> editProduct(
      {required FormData data, required int productId}) async {
    var res = await _api.updateProduct(data: data, productId: productId);

    if (res != null) {
      return Product.fromJson(res.data);
    }
    return null;
  }

  Future<bool?> deleteProduct({required int productId}) async {
    var res = await _api.deleteProduct(
      productId: productId,
    );

    if (res != null) {
      return res.data;
    }
    return null;
  }
}
