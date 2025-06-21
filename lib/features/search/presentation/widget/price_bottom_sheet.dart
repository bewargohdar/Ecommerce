import 'package:ecomerce/common/widget/button/basic_app_button.dart';
import 'package:flutter/material.dart';

class PriceBottomSheet extends StatefulWidget {
  final int? initialMinPrice;
  final int? initialMaxPrice;
  const PriceBottomSheet(
      {super.key, this.initialMinPrice, this.initialMaxPrice});

  @override
  State<PriceBottomSheet> createState() => _PriceBottomSheetState();
}

class _PriceBottomSheetState extends State<PriceBottomSheet> {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _minController.text = widget.initialMinPrice?.toString() ?? '';
    _maxController.text = widget.initialMaxPrice?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, {'min': null, 'max': null});
                  },
                  child: const Text('Clear',
                      style: TextStyle(color: Colors.white))),
              const Text(
                'Price',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _minController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Min',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _maxController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Max',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          BasicAppButton(
            onPressed: () {
              final minPrice = _minController.text.isEmpty
                  ? null
                  : int.tryParse(_minController.text);
              final maxPrice = _maxController.text.isEmpty
                  ? null
                  : int.tryParse(_maxController.text);

              Navigator.pop(context, {
                'min': minPrice,
                'max': maxPrice,
              });
            },
            title: 'Apply',
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
