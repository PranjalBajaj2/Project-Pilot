import 'package:projectpilot/features/auth/models/payment_model.dart';
import 'package:projectpilot/features/auth/services/payment_service.dart';

class PaymentRepository {
  final PaymentService _service = PaymentService();
  
  Future<void> addPaymnet(PaymentModel payment){
    return _service.addPayment(payment);
  }
  
  Stream<List<PaymentModel>> getPayments() {
    return _service.getPayments();
  }
  Future<void> updatePayment(PaymentModel payment){
    return _service.updatePayment(payment);
  }
  Future<void> deletePayment(String id){
    return _service.deletePayment(id);
  }
}