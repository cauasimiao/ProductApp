import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/products.dart';

abstract class ProductsRepository {
  Future<Either<Failure, Products>> saveProducts(
      {String id, String productName, String productPrice, String productFile});
  Future<Either<Failure, List<Products>>> getProducts();
}
