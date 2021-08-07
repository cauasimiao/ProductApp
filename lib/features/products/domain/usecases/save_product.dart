import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/products.dart';
import '../repositories/products_repository.dart';

class SaveProducts extends UseCase<Products, SaveProductParams> {
  final ProductsRepository repository;

  SaveProducts(this.repository);

  @override
  Future<Either<Failure, Products>> call(SaveProductParams params) async {
    final id = Uuid().v4();
    return await repository.saveProducts(
      id: id,
      productName: params.productName,
      productPrice: params.productPrice,
      productFile: params.productFile,
    );
  }
}

class SaveProductParams {
  String productName;
  String productPrice;
  String productFile;

  SaveProductParams({this.productName, this.productPrice, this.productFile});
}
