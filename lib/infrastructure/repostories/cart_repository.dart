import 'package:dio/dio.dart';
import 'package:timer_app/infrastructure/models/cart_model.dart';
import 'package:timer_app/infrastructure/repostories/base_repository.dart';

class CartRepository extends BaseRepository<CartModel>{
  final Dio client;
  String path = "/carts";
  CartRepository(this.client);
  @override
  Future<void> delete(String id) {

    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<CartModel>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<CartModel?> getOne(String id) async {
    final response = await client.get('$path/$id');
    final cart = CartModel.fromJson(response.data);
    return cart;
  }

  @override
  Future<void> store(CartModel data) {
    // TODO: implement store
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, CartModel data) {
    // TODO: implement update
    throw UnimplementedError();
  }

}