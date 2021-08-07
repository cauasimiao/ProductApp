import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductsEvent extends Equatable {
  ProductsEvent([List props = const <dynamic>[]]) : super(props);
}

class SaveProductEvent extends ProductsEvent {
  final String productName;
  final String productPrice;
  final String productFile;

  SaveProductEvent({this.productName, this.productPrice, this.productFile})
      : super([productName, productPrice, productFile]);
}

class ResetBlocEvent extends ProductsEvent {}

class GetProductsFromCache extends ProductsEvent {}
