import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projectpilot/features/auth/models/payment_model.dart';
import 'package:projectpilot/features/auth/repositories/payment_repository.dart';

class PaymentProvider extends ChangeNotifier{
  final PaymentRepository _repository = PaymentRepository();

  List<PaymentModel> _payments = [];
  List<PaymentModel> _filteredPayments = [];

  bool isLoading = false;

  String search = "";

  String? error;

  StreamSubscription? _subscription;

  List<PaymentModel> get payments => _filteredPayments;

  void listenPayments(){
    isLoading = true;

    notifyListeners();

    _subscription?.cancel();

    _subscription = _repository.getPayments().listen(
        (event){
          _payments = event;
          _filteredPayments = event;

          isLoading = false;

          notifyListeners();
        },
      onError: (e){
          error = e.toString();
          isLoading =false;
          notifyListeners();
      },
    );
  }
  void searchPayment(String value){
    if(value.isEmpty){
      _filteredPayments = _payments;
    }
    else{
      _filteredPayments = _payments.where((payments){
        return payments.clientName!.toLowerCase().contains(
          value.toLowerCase(),)||
        payments.projectName!.toLowerCase().contains(
        value.toLowerCase()
        );

      }).toList();
    }
    notifyListeners();
  }
  Future<void> addPayment(PaymentModel payment) async{
    await _repository.addPaymnet(payment);
  }
  Future<void> updatePayment(PaymentModel payment) async{
    await _repository.updatePayment(payment);
  }
  Future<void> deletePayment(String id) async{
    await _repository.deletePayment(id);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}