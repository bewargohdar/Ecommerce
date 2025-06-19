import 'package:ecomerce/common/widget/button/back_button.dart';
import 'package:ecomerce/common/widget/search.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback? onClearSearch;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final bool hideBackButton;

  const SearchAppBar({
    Key? key,
    required this.searchController,
    this.onClearSearch,
    this.onSubmitted,
    this.autofocus = true,
    this.hideBackButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          children: [
            if (!hideBackButton)
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: CustomBackButton(
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            Expanded(
              child: SearchField(
                controller: searchController,
                autofocus: autofocus,
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: onClearSearch,
                      )
                    : null,
                onSubmitted: onSubmitted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
