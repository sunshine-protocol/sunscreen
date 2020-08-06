abstract class ClientService {
  Future<bool> get ready;
  Future<bool> lock();
  Future<bool> unlock(String password);
  Future<String> setKey(String password, {String suri, String paperKey});
  Future<String> uid();
  Future<bool> hasKey();
  Future<String> balance();
  Future<String> transfer(String id, int amount);
  Future<int> mint();
}
