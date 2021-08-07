import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Products extends Equatable {
  final String id;
  final String nome;
  final String preco;
  final String productFile;

  Products({
    @required this.id,
    @required this.nome,
    @required this.preco,
    @required this.productFile,
  });
}
