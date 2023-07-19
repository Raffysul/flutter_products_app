import 'package:flutter/material.dart';
import 'package:flutter_products_app/services/product_api_service.dart';

import 'model/products_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductModel>? listOfProducts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  getProduct() async {
    listOfProducts = await ProductApiService().getProducts();
    if (listOfProducts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posts'), centerTitle: true),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
            itemCount: listOfProducts?.length,
            itemBuilder: (context, index) {
              final myProduct = listOfProducts![index];
              return Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300],
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            myProduct.imageUrl[0],
                            width: 180,
                            height: 200,
                          )),
                    ),
                    const SizedBox(width: 16,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myProduct.title,
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10,),
                          Text(
                              '\$${myProduct.price.toStringAsFixed(2)}',
                            maxLines: 2,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
