import 'dart:convert';

import 'package:cleanarchitecture/features/products/domain/entities/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/products_model.dart';

abstract class ProductsLocalDataSource {
  /// Gets the cached [ProductsModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<List<Products>> getProducts();

  Future<void> cacheProducts(ProductsModel productsToCache);
}

const CACHED_NUMBER_TRIVIA = 'CACHED_NUMBER_TRIVIA';

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<List<Products>> getProducts() {
    final jsonString = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');

    List<dynamic> decoded = [];

    if (jsonString != null) {
      decoded = json.decode(jsonString);

      List<Products> productsList =
          decoded.map((product) => ProductsModel.fromJson(product)).toList();
      return Future.value(productsList);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheProducts(ProductsModel product) {
    final jsonString = sharedPreferences.getString('CACHED_NUMBER_TRIVIA');

    List<dynamic> decoded = [];

    if (jsonString != null) {
      decoded = json.decode(jsonString);
    }

    List<Products> productsList =
        decoded.map((e) => ProductsModel.fromJson(e)).toList();

    productsList.add(product);

    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(productsList),
    );
  }
}
