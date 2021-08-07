import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cleanarchitecture/features/products/domain/usecases/get_products.dart';
import 'package:cleanarchitecture/features/products/domain/usecases/save_product.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/input_converter.dart';
import '../../domain/entities/products.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final GetProducts getProducts;
  final SaveProducts saveProducts;
  final InputConverter inputConverter;

  ProductsBloc({
    // Changed the name of the constructor parameter (cannot use 'this.')
    @required GetProducts getProducts,
    @required SaveProducts saveProducts,
    @required this.inputConverter,
    // Asserts are how you can make sure that a passed in argument is not null.
    // We omit this elsewhere for the sake of brevity.
  })  : assert(getProducts != null),
        assert(saveProducts != null),
        assert(inputConverter != null),
        saveProducts = saveProducts,
        getProducts = getProducts;

  @override
  ProductsState get initialState => Empty();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is GetProductsFromCache) {
      yield LoadingProducts();
      final failureOrProduct = await getProducts(
        NoParams(),
      );
      yield failureOrProduct.fold(
        (failure) => Error(message: _mapFailureToMessage(failure)),
        (product) => LoadedProducts(product: product),
      );
    }
    if (event is SaveProductEvent) {
      final res = await saveProducts(
        SaveProductParams(
            productName: event.productName,
            productPrice: event.productPrice,
            productFile: event.productFile),
      );

      yield SavedProductState();
    }

    if (event is ResetBlocEvent) {
      yield Empty();
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
