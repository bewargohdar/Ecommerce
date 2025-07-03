import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ecomerce/common/widget/button/basic_app_button.dart';
import 'package:ecomerce/core/config/theme/app_color.dart';
import 'package:ecomerce/features/cart/domain/entity/cart_entity.dart';
import 'package:ecomerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:ecomerce/features/cart/presentation/bloc/cart_event.dart';
import 'package:ecomerce/features/cart/presentation/bloc/cart_state.dart';
import 'package:ecomerce/features/cart/presentation/widget/cart_item_widget.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(FetchCartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Cart', style: TextStyle(color: AppColors.white)),
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.secondBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: AppColors.white, size: 15),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Remove All',
                style: TextStyle(color: AppColors.white)),
          )
        ],
      ),
      body: BlocSelector<CartBloc, CartState, CartState>(
        selector: (state) => state,
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartError) {
            return Center(
                child: Text(state.error ?? 'An unknown error occurred'));
          }
          if (state is CartLoaded) {
            if (state.cart!.products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/vectors/cart_bag.svg',
                      width: 150,
                      height: 150,
                      colorFilter:
                          const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Your cart is empty!',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Looks like you haven\'t added anything to your cart yet.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.cart!.products.length,
              itemBuilder: (context, index) {
                return CartItemWidget(cartItem: state.cart!.products[index]);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocSelector<CartBloc, CartState, CartEntity?>(
        selector: (state) =>
            (state is CartLoaded && state.cart!.products.isNotEmpty)
                ? state.cart
                : null,
        builder: (context, cart) {
          if (cart != null) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(color: AppColors.background),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[400])),
                      Text('\$${cart.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping Cost',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[400])),
                      const Text('\$8.00',
                          style:
                              TextStyle(fontSize: 16, color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tax',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[400])),
                      const Text('\$0.00',
                          style:
                              TextStyle(fontSize: 16, color: AppColors.white)),
                    ],
                  ),
                  const Divider(color: Colors.grey, height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[400])),
                      Text('\$${cart.discountedTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.secondBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.local_offer, color: Colors.grey),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter Coupon Code',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_forward_ios,
                              color: AppColors.white, size: 18),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  BasicAppButton(
                    onPressed: () {},
                    title: 'Checkout',
                    height: 50,
                    radius: 30,
                    color: AppColors.primary,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
