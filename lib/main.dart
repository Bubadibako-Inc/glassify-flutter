import 'package:flutter/material.dart';
import 'package:glassify_flutter/config/routes.dart';

void main() {
  runApp(const MyApp());
}

final Routes _routes = Routes();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Glassify',
      debugShowCheckedModeBanner: false,
      routerConfig: _routes.router,
    );
  }
}
