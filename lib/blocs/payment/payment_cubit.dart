import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vending_machine/models/product.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentState());

  void initialProduct(Product product) async {
    emit(state.copyWith(
      product: product,
    ));
  }

  void receiveMoney(double money) {
    final receivedMoney = state.receivedMoney + money;

    final change = receivedMoney - state.product!.price;
    if (change > 0) {
      emit(state.copyWith(
        change: change,
      ));
    }

    emit(state.copyWith(
      receivedMoney: receivedMoney,
    ));
  }
}
