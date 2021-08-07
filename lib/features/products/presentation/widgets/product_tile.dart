import 'dart:convert';

import 'package:cleanarchitecture/features/products/domain/entities/products.dart';
import 'package:cleanarchitecture/features/products/presentation/widgets/utility.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final Products product;

  const ProductTile({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(product);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(),
                  child: product.productFile != null
                      ? Image.memory(
                          base64Decode(product.productFile),
                          fit: BoxFit.fill,
                        )
                      : Container()),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.nome}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("R\$ ${product.preco}"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
