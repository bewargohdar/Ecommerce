import 'package:ecomerce/features/cart/domain/entity/cart_entity.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  final CartEntity? cart;
  final String? error;

  const CartState({this.cart, this.error});

  @override
  List<Object?> get props => [cart, error];
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  const CartLoaded(CartEntity cart) : super(cart: cart);
}

class CartError extends CartState {
  const CartError(String error) : super(error: error);
}
