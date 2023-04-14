import 'package:dio/dio.dart';
import 'package:timer_app/infrastructure/models/models.dart';
import 'package:timer_app/infrastructure/repostories/base_repository.dart';

class ProductRepository extends BaseRepository<ProductModel> {
  final Dio client;
  String path = "/products";

  ProductRepository(this.client);

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAll() async {
    final res = await client.get(path);
    List<ProductModel> none = [];
    // if (res.data != null) {
    for (final item in res.data) {
      none.add(ProductModel.fromJson(item));
    }
    //   return none;
    // }
    return none;
  }

  @override
  Future<ProductModel?> getOne(String id) async {
    final res = await client.get<ProductModel>("$path/$id");
    return res.data;
  }

  @override
  Future<void> store(ProductModel data) {
    // TODO: implement store
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, ProductModel data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
