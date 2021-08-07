import 'package:cleanarchitecture/features/products/data/datasource/products_local_datasource.dart';
import 'package:cleanarchitecture/features/products/data/models/products_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/products.dart';
import '../../domain/repositories/products_repository.dart';

typedef Future<Products> _ConcreteOrRandomChooser();

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProductsRepositoryImpl({
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Products>>> getProducts() async {
    final localTrivia = await localDataSource.getProducts();
    return Right(localTrivia);
  }

  @override
  Future<Either<Failure, Products>> saveProducts(
      {String id,
      String productName,
      String productPrice,
      String productFile}) async {
    final product = new ProductsModel(
        id: id,
        productName: productName,
        productPrice: productPrice,
        productFile: productFile);
    final localProduct = await localDataSource.cacheProducts(product);
  }
}
