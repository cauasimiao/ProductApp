import 'package:cleanarchitecture/features/products/presentation/bloc/bloc.dart';
import 'package:cleanarchitecture/features/products/presentation/pages/products_list_page.dart';
import 'package:cleanarchitecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsRow extends StatelessWidget {
  final String addProductTitle;
  final Function addProductOnClick;
  const ButtonsRow({Key key, this.addProductTitle, this.addProductOnClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            child: Text(
              addProductTitle,
              style: TextStyle(fontSize: 16, color: Color(0xFFF2EDDB)),
            ),
            color: Color(0xFF10223D),
            textTheme: ButtonTextTheme.primary,
            onPressed: addProductOnClick,
          ),
        ),
        Container(
          height: 70,
          width: MediaQuery.of(context).size.width / 2,
          child: RaisedButton(
            child: Text(
              'Veja seus produtos',
              style: TextStyle(fontSize: 16, color: Color(0xFFF2EDDB)),
            ),
            color: Color(0xFFD6533C),
            textTheme: ButtonTextTheme.primary,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: sl<ProductsBloc>(),
                    child: ProductsListPage(),
                  ),
                ),
              );
              // BlocProvider.of<ProductsBloc>(context)
              //     .dispatblocch(SaveProductEvent(
              //         productName: productName,
              //         productPrice: preco));
            },
          ),
        ),
      ],
    );
  }
}
