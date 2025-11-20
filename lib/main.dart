import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_flutter_shop/core/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sticky_flutter_shop/viewModels/products_view_model.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsViewModel()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Shop',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: appRouter,
      )
    );
  }
}
