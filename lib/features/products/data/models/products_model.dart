import 'package:meta/meta.dart';

import '../../domain/entities/products.dart';

class ProductsModel extends Products {
  ProductsModel(
      {@required String id,
      @required String productName,
      @required String productPrice,
      @required String productFile})
      : super(
          id: id,
          nome: productName,
          preco: productPrice,
          productFile: productFile,
        );
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
        id: json['id'],
        productName: json['productName'],
        // The 'num' type can be both a 'double' and an 'int'
        productPrice: json['productPrice'],
        productFile: json['productFile']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': nome,
      'productPrice': preco,
      'productFile': productFile
    };
  }
}
