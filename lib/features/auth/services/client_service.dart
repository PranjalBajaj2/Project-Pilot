import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/client_model.dart';

class ClientService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference get _clientCollection =>
      firestore.collection("clients");

  Future<void> addClient(ClientModel client) async {

    await _clientCollection.add(client.toMap());

  }
  Stream<List<ClientModel>> getClients() {
    return _clientCollection
        .where(
      "userId",
      isEqualTo: auth.currentUser!.uid,
    )
        .snapshots()
        .map((snapshot) {


      return snapshot.docs.map((doc) {
        return ClientModel.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  Future<void> updateClient(ClientModel client) async {

    await _clientCollection
        .doc(client.id)
        .update(client.toMap());

  }

  Future<void> deleteClient(String id) async {

    await _clientCollection.doc(id).delete();

  }
}