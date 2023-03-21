import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machine/blocs/payment/payment_cubit.dart';
import 'package:vending_machine/config/app_utilities.dart';
import 'package:vending_machine/models/models.dart';

class PaymentPage extends StatefulWidget {
  static const String route = '/payment';

  final Product product;

  const PaymentPage({
    super.key,
    required this.product,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final moneys = [
    Money(value: 2000),
    Money(value: 5000),
    Money(value: 10000),
    Money(value: 20000),
    Money(value: 50000),
  ];

  @override
  void initState() {
    super.initState();

    context.read<PaymentCubit>().initialProduct(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state.receivedMoney >= state.product!.price) {
          if (state.change > 0) {
            final snackBar = SnackBar(
              content: Text(
                  'Your change is Rp ${AppUtilities.currency.format(state.change)}'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Payment'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                    '${widget.product.name} Price: ${widget.product.price}'),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text('Money received: ${state.receivedMoney}'),
              ),

              // Payment
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 40),
                  itemCount: moneys.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 8),
                      child: ElevatedButton(
                        onPressed: () => _onReceivedMoney(index),
                        child: Text(
                            'Rp ${AppUtilities.currency.format(moneys[index].value)}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onReceivedMoney(int index) async {
    context.read<PaymentCubit>().receiveMoney(moneys[index].value);
  }
}
