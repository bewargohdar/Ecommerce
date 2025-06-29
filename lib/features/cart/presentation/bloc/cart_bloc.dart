import 'package:bloc/bloc.dart';
import 'package:ecomerce/core/usecase/usecase.dart';
import 'package:ecomerce/features/cart/domain/usecase/get_cart_usecase.dart';
import 'package:ecomerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecomerce/features/cart/presentation/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUsecase _getCartUsecase;
  CartBloc(this._getCartUsecase) : super(const CartLoading()) {
    on<FetchCartEvent>(_onFetchCart);
  }

  void _onFetchCart(FetchCartEvent event, Emitter<CartState> emit) async {
    emit(const CartLoading());
    final result = await _getCartUsecase(NoParams());
    result.fold(
      (failure) => emit(CartError(failure)),
      (cart) => emit(CartLoaded(cart)),
    );
  }
}
