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
}