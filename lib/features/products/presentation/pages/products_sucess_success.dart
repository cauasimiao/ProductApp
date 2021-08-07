import 'package:cleanarchitecture/features/products/presentation/bloc/bloc.dart';
import 'package:cleanarchitecture/features/products/presentation/pages/products_list_page.dart';
import 'package:cleanarchitecture/features/products/presentation/widgets/buttons_row.dart';
import 'package:cleanarchitecture/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsSucessPage extends StatelessWidget {
  final ProductsBloc bloc;
  const ProductsSucessPage({Key key, this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Seu produto foi adicionado com sucesso, o que deseja fazer a seguir? ",
            style: TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        ButtonsRow(
          addProductOnClick: () {
            BlocProvider.of<ProductsBloc>(context).dispatch(ResetBlocEvent());
          },
          addProductTitle: "Adicionar novo produto",
        )
      ],
    );
  }
}
