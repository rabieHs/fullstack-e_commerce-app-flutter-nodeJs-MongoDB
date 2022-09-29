import 'package:flutter/material.dart';
import 'package:fullstack_e_commerce_app/common/widgets/loader.dart';
import 'package:fullstack_e_commerce_app/features/account/widgets/single_product.dart';
import 'package:fullstack_e_commerce_app/features/admin/services/admin_services.dart';

import '../../../models/product.dart';
import 'add_product_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  List<Product>? productsList;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    productsList = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(
    Product product,
    int index,
  ) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuucess: () {
        productsList!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productsList == null
          ? const Loader()
          : GridView.builder(
              itemCount: productsList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = productsList![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(image: productData.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            child: Text(
                          productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        )),
                        IconButton(
                            onPressed: () => deleteProduct(productData, index),
                            icon: const Icon(Icons.delete_outline))
                      ],
                    )
                  ],
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        tooltip: 'Add a product',
        onPressed: navigateToAddProduct,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
