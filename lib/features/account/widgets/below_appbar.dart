import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/constants/global_variables.dart';
import 'package:fullstack_e_commerce_app/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: const BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: 'Hello, ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
