import 'package:flutter/cupertino.dart';
import 'package:timer_app/infrastructure/models/models.dart';

class CartProvider extends ChangeNotifier{
  List<ProductModel> products = [];

  double get subtotal {
    return products.fold(0, (sum, product) => sum + (product.price * product.quantity));
  }

  double get tax {
    return subtotal * 0.1;
  }

  double get shipping {
    return products.isNotEmpty ? 5.0:0;
  }

  double get total {
    return subtotal + tax + shipping;
  }

  void addProduct(ProductModel product) {
    int index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index].quantity++;
      notifyListeners();
      return;
    }
    product.quantity = 1;
    products.add(product);
    notifyListeners();
    return;
  }

  void removeProduct(ProductModel product) {
    int index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      if (products[index].quantity > 1) {
        products[index].quantity--;
      } else {
        products.removeAt(index);
      }
    }
    notifyListeners();
  }
}