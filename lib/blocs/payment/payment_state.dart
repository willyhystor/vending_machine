part of 'payment_cubit.dart';

class PaymentState extends Equatable {
  final Product? product;
  final double receivedMoney;
  final double change;

  const PaymentState({
    this.product,
    this.receivedMoney = 0,
    this.change = 0,
  });

  PaymentState copyWith({
    Product? product,
    double? receivedMoney,
    double? change,
  }) {
    return PaymentState(
      product: product ?? this.product,
      receivedMoney: receivedMoney ?? this.receivedMoney,
      change: change ?? this.change,
    );
  }

  @override
  List<Object?> get props => [
        product,
        receivedMoney,
        change,
      ];
}
