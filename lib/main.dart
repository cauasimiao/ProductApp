import 'package:cleanarchitecture/features/products/presentation/pages/products_page.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF10223D),
        accentColor: Color(0xFF333652),
      ),
      home: ProductsPage(),
    );
  }
}
