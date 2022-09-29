import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:fullstack_e_commerce_app/constants/error_hundling.dart';
import 'package:fullstack_e_commerce_app/constants/global_variables.dart';
import 'package:fullstack_e_commerce_app/constants/utils.dart';
import 'package:fullstack_e_commerce_app/models/product.dart';
import 'package:fullstack_e_commerce_app/models/user.dart';
import 'package:fullstack_e_commerce_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  //post products

  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      final cloudinary = CloudinaryPublic('dgvyd70ml', 'ohvddsp6');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: product.toJson());
      httpErrorHundle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  //GET ALL PRODUCTS
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token
        },
      );
      httpErrorHundle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuucess,
  }) async {
    try {
      final userProvider =
          Provider.of<UserProvider>(context, listen: false).user;

      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.token,
        },
        body: jsonEncode({'id': product.id}),
      );
      httpErrorHundle(
          response: res,
          context: context,
          onSuccess: () {
            onSuucess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
