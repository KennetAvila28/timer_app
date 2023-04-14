import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/presentation/providers/cart_provider.dart';

class ShopCartPage extends StatelessWidget {
  const ShopCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: const [
          Icon(Icons.shopping_cart_rounded),
          Padding(padding: EdgeInsets.only(right: 5)),
          Text('Shopping Cart'),
        ],
      )),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            if (cartProvider.products.isNotEmpty)
              SizedBox(
                height: 500,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: cartProvider.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = cartProvider.products[index];

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: Image.network(product.image).image,
                      ),
                      title: Text(product.title),
                      subtitle: Text('\$${product.price}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              cartProvider
                                  .removeProduct(cartProvider.products[index]);
                            },
                          ),
                          Text(cartProvider.products[index].quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              cartProvider
                                  .addProduct(cartProvider.products[index]);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              ),
              Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal'),
                    Text('\$${cartProvider.subtotal.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Impuesto'),
                    Text('\$${cartProvider.tax.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Envío'),
                    Text('\$${cartProvider.shipping.toStringAsFixed(2)}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('\$${cartProvider.total.toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
