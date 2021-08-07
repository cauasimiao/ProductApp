import 'package:cleanarchitecture/features/products/presentation/widgets/product_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class ProductsListPage extends StatefulWidget {
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProductsBloc>(context).dispatch(GetProductsFromCache());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ProductsBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF2EDDB),
      appBar: AppBar(
        backgroundColor: Color(0xFF10223D),
        title: Text('Seus produtos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: buildBody(context, bloc),
      ),
    );
  }

  BlocProvider<ProductsBloc> buildBody(BuildContext context, bloc) {
    return BlocProvider(
      builder: (_) => bloc,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            // Top half
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is Empty) {
                  return Text("Adicione produtos");
                } else if (state is LoadingProducts) {
                } else if (state is LoadedProducts) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: state.product.length,
                      itemBuilder: (context, index) {
                        return ProductTile(
                          product: state.product[index],
                        );
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            // Bottom half
          ],
        ),
      ),
    );
  }
}
