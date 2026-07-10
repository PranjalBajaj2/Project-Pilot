import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projectpilot/features/auth/models/payment_model.dart';

class PaymentService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  CollectionReference get _paymentCollection =>
      firestore.collection("payments");

  Future<void> addPayment(PaymentModel payment) async {
    try {
      await _paymentCollection.add(payment.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<PaymentModel>> getPayments() {
    return _paymentCollection
        .where("userId", isEqualTo: auth.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return PaymentModel.fromMap(
              doc.id,
              doc.data() as Map<String, dynamic>,
            );
          }).toList();
        });
  }

  Future<void> updatePayment(PaymentModel payment) async {
    try {
      await _paymentCollection.doc(payment.id).update(payment.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePayment(String id) async {
    try {
      await _paymentCollection.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
