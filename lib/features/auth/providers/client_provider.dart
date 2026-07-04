import 'dart:async';

import 'package:flutter/material.dart';

import '../models/client_model.dart';
import '../repositories/client_repository.dart';

class ClientProvider extends ChangeNotifier {
  final ClientRepository repository = ClientRepository();

  List<ClientModel> _clients = [];

  List<ClientModel> get clients => _filteredClients;

  List<ClientModel> _filteredClients = [];

  bool isLoading = false;

  String search = "";

  String? error;

  StreamSubscription? _subscription;

  void listenClients() {
    isLoading = true;

    notifyListeners();

    _subscription?.cancel();

    _subscription = repository.getClients().listen(
      (event) {
        _clients = event;
        _applySearch();
        isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        isLoading = false;
        error = e.toString();
        notifyListeners();
      },
    );
  }

  void searchClient(String value) {
    search = value;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (search.isEmpty) {
      _filteredClients = _clients;
      return;
    }

    _filteredClients = _clients.where((client) {
      return client.name!.toLowerCase().contains(search.toLowerCase()) ||
          client.company!.toLowerCase().contains(search.toLowerCase());
    }).toList();
  }

  Future<void> addClient(ClientModel client) async {
    await repository.addClient(client);
  }

  Future<void> updateClient(ClientModel client) async {
    await repository.updateClient(client);
  }

  Future<void> deleteClient(String id) async {
    await repository.deleteClient(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();

    super.dispose();
  }
}
