import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/constants/global_variables.dart';
import 'package:fullstack_e_commerce_app/features/account/widgets/single_product.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    'https://i.pravatar.cc/100',
    'https://i.pravatar.cc/200',
    'https://i.pravatar.cc/300',
    'https://i.pravatar.cc/100',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 18,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        //Desplay orders
        Container(
            height: 170,
            padding: EdgeInsets.only(left: 10, top: 20, right: 0),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: ((context, index) {
                return SingleProduct(image: list[index]);
              }),
            ))
      ],
    );
  }
}
