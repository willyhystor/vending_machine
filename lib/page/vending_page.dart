import 'package:flutter/material.dart';
import 'package:vending_machine/config/app_utilities.dart';
import 'package:vending_machine/models/product.dart';
import 'package:vending_machine/page/payment_page.dart';

class VendingPage extends StatefulWidget {
  static const String route = '/vending';

  const VendingPage({super.key});

  @override
  State<VendingPage> createState() => _VendingPageState();
}

class _VendingPageState extends State<VendingPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();

    final biskuit = Product(
      name: 'Biskuit',
      price: 2000,
      stock: 2,
    );
    final chips = Product(
      name: 'Chips',
      price: 5000,
      stock: 1,
    );
    final oreo = Product(
      name: 'Oreo',
      price: 10000,
      stock: 3,
    );
    final tango = Product(
      name: 'Tango',
      price: 10000,
      stock: 4,
    );
    final cokelat = Product(
      name: 'Cokelat',
      price: 5000,
      stock: 2,
    );

    products = [
      biskuit,
      chips,
      oreo,
      tango,
      cokelat,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vending Machine App'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 40),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _onSelectProduct(index),
                    child: Text(
                        '${products[index].name} - Rp ${AppUtilities.currency.format(products[index].price)}'),
                  ),
                ),
                const SizedBox(width: 12),
                Text('Stock: ${products[index].stock}'),
              ],
            ),
          );
        },
      ),
    );
  }

  _onSelectProduct(int index) async {
    if (products[index].stock <= 0) {
      final snackBar = SnackBar(
        content: Text('${products[index].name} is empty'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final result = await Navigator.pushNamed(
        context,
        PaymentPage.route,
        arguments: products[index],
      );

      if (result != null && result as bool && result) {
        setState(() {
          products[index].stock--;
        });
      }
    }
  }
}
