import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/infrastructure/models/models.dart';
import 'package:timer_app/infrastructure/repostories/repositories.dart';
import 'package:timer_app/presentation/providers/cart_provider.dart';

class ShopIndexPage extends StatelessWidget {
  const ShopIndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder<List<ProductModel>>(
        future: Provider.of<ProductRepository>(context).getAll(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final product = snapshot.data![index];
                return ListTile(
                  leading: CircleAvatar(
                      foregroundImage: Image.network(product.image).image),
                  title: Text(product.title),
                  subtitle: Row(
                    children: [
                      const Text('price: '),
                      const Icon(
                        Icons.attach_money,
                        size: 20,
                      ),
                      Text('${product.price}')
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      size: 32,
                    ),
                    onPressed: () async {
                      cartProvider.addProduct(product);
                    },
                  ),
                );
              },
              separatorBuilder: (_, index) => const Divider(),
              itemCount: snapshot.data!.length,
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("No data"),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 4,
            ));
          }
        },
      ),
    );
  }
}
