import 'package:flutter/material.dart';
import 'package:vending_machine/config/app_routes.dart';
import 'package:vending_machine/page/vending_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      onGenerateRoute: (_) => AppRoutes.onGenerateRoute(_),
      initialRoute: VendingPage.route,
    );
  }
}
