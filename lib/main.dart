import 'package:example_api/providers/auth_provider.dart';
import 'package:example_api/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:example_api/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        routes: {'/': (context) => const SplashPage()},
      ),
    );
  }
}
