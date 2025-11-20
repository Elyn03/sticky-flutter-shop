import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sticky_flutter_shop/theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String backButtonLink;

  const CustomAppBar({super.key, required this.title, this.backButtonLink = ""});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      title: Text(title),
      leading: backButtonLink.isNotEmpty
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                context.go(backButtonLink);
              },
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
