import '../models/client_model.dart';
import '../services/client_service.dart';

class ClientRepository {
  final ClientService service = ClientService();

  Future<void> addClient(ClientModel client) {
    return service.addClient(client);
  }

  Stream<List<ClientModel>> getClients() {
    return service.getClients();
  }

  Future<void> updateClient(ClientModel client) {
    return service.updateClient(client);
  }

  Future<void> deleteClient(String id) {
    return service.deleteClient(id);
  }
}
