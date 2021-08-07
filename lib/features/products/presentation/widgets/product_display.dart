import 'package:cleanarchitecture/features/products/domain/entities/products.dart';
import 'package:flutter/cupertino.dart';

class ProductsDisplay extends StatelessWidget {
  final Products products;

  const ProductsDisplay({
    Key key,
    this.products,
  })  : assert(products != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: <Widget>[
          // Fixed size, doesn't scroll
          Text(
            products.preco.toString(),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Expanded makes it fill in all the remaining space
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  products.nome,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
