import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomerce/common/widget/appbar/app_bar.dart';
import 'package:ecomerce/config/assets/app_vectors.dart';
import 'package:ecomerce/config/theme/app_color.dart';
import 'package:ecomerce/features/product/domain/entity/product.dart';
import 'package:ecomerce/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecomerce/features/product/presentation/widget/info_block.dart';
import 'package:ecomerce/features/product/presentation/widget/review_card.dart';
import 'package:ecomerce/features/product/presentation/widget/selection_bottom_sheets.dart';
import 'package:ecomerce/features/product/presentation/widget/setting_option_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  SizeOption _selectedSize = SizeOption.S;
  final List<Color> _availableColors = [
    Colors.green,
    const Color(0xFF3C415C),
    const Color(0xFF5C3C3C),
    const Color(0xFFC8A364)
  ];
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = _availableColors[0];
    context.read<ProductBloc>().add(GetProductDetailEvent(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BasicAppbar(
        action: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppVectors.favorite, width: 24, height: 24),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }
          if (state.productDetail != null) {
            final product = state.productDetail!;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: AnimationLimiter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimationConfiguration.staggeredList(
                            position: 0,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Container(
                                  color: AppColors.white,
                                  height: 350,
                                  child: PageView.builder(
                                    itemCount: product.images.length,
                                    itemBuilder: (context, index) {
                                      return CachedNetworkImage(
                                        imageUrl: product.images[index],
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          AnimationConfiguration.staggeredList(
                            position: 1,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.title,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        '\$${product.price.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      GestureDetector(
                                        onTap: () => showSizeSelectionSheet(
                                          context,
                                          currentSize: _selectedSize,
                                          onSizeSelected: (size) {
                                            setState(() {
                                              _selectedSize = size;
                                            });
                                          },
                                        ),
                                        child: SettingOptionTile(
                                          title: 'Size',
                                          child: Row(
                                            children: [
                                              Text(
                                                  _selectedSize
                                                      .toString()
                                                      .split('.')
                                                      .last,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                  Icons.keyboard_arrow_down),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: () => showColorSelectionSheet(
                                          context,
                                          availableColors: _availableColors,
                                          currentColor: _selectedColor,
                                          onColorSelected: (color) {
                                            setState(() {
                                              _selectedColor = color;
                                            });
                                          },
                                        ),
                                        child: SettingOptionTile(
                                          title: 'Color',
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                  color: _selectedColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                  Icons.keyboard_arrow_down),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondBackground,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Quantity',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(Icons.remove,
                                                      color: Colors.white,
                                                      size: 18),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                  child: Center(
                                                      child: Text('1',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: AppColors.primary,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(Icons.add,
                                                      color: Colors.white,
                                                      size: 18),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      InfoBlock(
                                        title: 'Description',
                                        content: product.description,
                                      ),
                                      const SizedBox(height: 24),
                                      InfoBlock(
                                        title: 'Shipping & Returns',
                                        content: product.shippingInformation,
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        'Reviews',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        '${product.rating.toStringAsFixed(1)} Ratings',
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        '${product.reviews.length} Reviews',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600]),
                                      ),
                                      const SizedBox(height: 16),
                                      ...product.reviews.take(2).map((review) =>
                                          ReviewCard(review: review)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Add to Bag',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Product not found.'));
        },
      ),
    );
  }
}
