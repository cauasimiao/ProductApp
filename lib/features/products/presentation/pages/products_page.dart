import 'package:cleanarchitecture/features/products/presentation/pages/products_sucess_success.dart';
import 'package:cleanarchitecture/features/products/presentation/widgets/buttons_row.dart';
import 'package:cleanarchitecture/features/products/presentation/widgets/save_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF2EDDB),
        appBar: AppBar(
          backgroundColor: Color(0xFF10223D),
          title: Text('Gerenciador de produtos'),
          centerTitle: true,
        ),
        body: buildBody(context));
  }

  BlocProvider<ProductsBloc> buildBody(BuildContext context) {
    TextEditingController nameController = new TextEditingController();
    TextEditingController precoController = new TextEditingController();
    String productName = '';
    String preco = '';
    String productFile = '';

    return BlocProvider(
        builder: (_) => sl<ProductsBloc>(),
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is Empty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE69451)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE69451)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        hintText: "Digite o nome do produto", //hint text
                        prefixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color(0xFFFFFCF2), //prefix iocn
                        hintStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.normal),
                        //hint text style
                        //label style
                      ),
                      onChanged: (value) {
                        productName = value;
                        // inputStr = value;
                      },
                      onSubmitted: (_) {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: precoController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE69451)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFE69451)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        hintText: "Digite o preço do produto", //hint text
                        prefixIcon: Icon(Icons.monetization_on),
                        filled: true,
                        fillColor: Color(0xFFFFFCF2), //prefix iocn
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal), //hint text style
                      ),
                      onChanged: (value) {
                        preco = value;
                        // inputStr = value;
                      },
                      onSubmitted: (_) {},
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      child: Text(
                        "Selecione uma imagem",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFF2EDDB)),
                      ),
                      color: Color(0xFF10223D),
                      textTheme: ButtonTextTheme.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaveImage(
                              onImageSelected: (String file) {
                                setState(() {
                                  productFile = file;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonsRow(
                    addProductOnClick: () {
                      nameController.clear();
                      precoController.clear();

                      print(productFile);
                      BlocProvider.of<ProductsBloc>(context).dispatch(
                        SaveProductEvent(
                          productName: productName,
                          productPrice: preco,
                          productFile: productFile,
                        ),
                      );
                    },
                    addProductTitle: "Adicionar produto",
                  )
                ],
              );
            } else if (state is SavedProductState) {
              return ProductsSucessPage();
            }
          },
        ));
  }
}
