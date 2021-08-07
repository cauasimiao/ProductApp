import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/products.dart';
import '../repositories/products_repository.dart';

class GetProducts extends UseCase<List<Products>, NoParams> {
  final ProductsRepository repository;

  GetProducts(this.repository);

  @override
  Future<Either<Failure, List<Products>>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
