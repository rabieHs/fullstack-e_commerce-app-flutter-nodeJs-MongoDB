import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../constants/error_hundling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class ProductDetailsServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: jsonEncode({
            'id': product.id!,
          }));
      httpErrorHundle(
        response: res,
        context: context,
        onSuccess: () {
          User userr = user.copyWith(cart: jsonDecode(res.body)['cart']);
          userprovider.setUserFromModel(userr);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: jsonEncode({'id': product.id!, 'rating': rating}));
      httpErrorHundle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
