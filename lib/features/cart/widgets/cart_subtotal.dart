import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int sum = 0;
    final user = Provider.of<UserProvider>(context).user;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(children: [
        const Text(
          'Subtotal, ',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          '\$$sum',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ]),
    );
  }
}
