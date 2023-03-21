import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machine/blocs/payment/payment_cubit.dart';
import 'package:vending_machine/models/models.dart';
import 'package:vending_machine/page/payment_page.dart';
import 'package:vending_machine/page/vending_page.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return PageRouteBuilder(
      settings: routeSettings,
      transitionsBuilder: (_, a, sa, c) {
        // Slide from Bottom
        // var begin will define which position the animation will start
        const begin = Offset(1.0, 0.0);
        // Offset.infinite will act as default transition
        // Offset.zero will pop new screen from bottom
        const end = Offset.zero;
        const curve = Curves.fastLinearToSlowEaseIn;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: a.drive(tween),
          child: c,
        );
      },
      pageBuilder: (_, a, sa) {
        switch (routeSettings.name) {
          case VendingPage.route:
            return const VendingPage();

          case PaymentPage.route:
            final product = routeSettings.arguments as Product;

            return BlocProvider(
              create: (context) => PaymentCubit(),
              child: PaymentPage(product: product),
            );

          default:
            return const Center(
              child: Text('Page not found'),
            );
        }
      },
    );
  }
}
