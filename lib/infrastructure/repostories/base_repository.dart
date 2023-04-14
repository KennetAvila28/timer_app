abstract class BaseRepository<T>{

  Future<List<T>> getAll();
  Future<T?> getOne(String id);
  Future<void> store(T data);
  Future<void> update(String id,T data);
  Future<void> delete(String id);
}