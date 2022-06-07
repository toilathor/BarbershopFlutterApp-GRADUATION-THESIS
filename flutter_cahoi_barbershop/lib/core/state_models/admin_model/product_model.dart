import 'package:dio/dio.dart';
import 'package:flutter_cahoi_barbershop/core/services/product_service.dart';
import 'package:flutter_cahoi_barbershop/core/state_models/base.dart';
import 'package:flutter_cahoi_barbershop/service_locator.dart';
import 'package:image_picker/image_picker.dart';

class ProductModel extends BaseModel {
  final _productService = locator<ProductService>();

  Future<bool> createProduct(
      {required Map<String, dynamic> data, required PickedFile image}) async {
    data.addAll({
      "image": await MultipartFile.fromFile(
        image.path,
      )
    });

    FormData formData = FormData.fromMap(data);

    var res = await _productService.createProduct(data: formData);

    if (res != null) {
      return true;
    }

    return false;
  }

  Future<bool> editProduct({
    required Map<String, dynamic> data,
    PickedFile? image,
    required int productId,
  }) async {
    if (image != null) {
      data.addAll({
        "image": await MultipartFile.fromFile(
          image.path,
        )
      });
    }

    FormData formData = FormData.fromMap(data);

    var res = await _productService.editProduct(
      data: formData,
      productId: productId,
    );
    if (res != null) {
      return true;
    }

    return false;
  }

  Future<bool> deleteProduct({required int productId}) async {
    return await _productService.deleteProduct(productId: productId) ?? false;
  }
}
