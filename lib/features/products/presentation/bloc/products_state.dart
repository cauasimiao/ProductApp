import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/products.dart';

@immutable
abstract class ProductsState extends Equatable {
  ProductsState([List props = const <dynamic>[]]) : super(props);
}

class Empty extends ProductsState {}

class LoadingProducts extends ProductsState {}

class LoadedProducts extends ProductsState {
  final List<Products> product;

  LoadedProducts({@required this.product}) : super([product]);
}

class SavedProductState extends ProductsState {}

class Error extends ProductsState {
  final String message;

  Error({@required this.message}) : super([message]);
}
