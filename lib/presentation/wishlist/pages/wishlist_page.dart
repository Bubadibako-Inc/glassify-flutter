import 'package:flutter/material.dart';

import '../widgets/wishlist_appbar.dart';
import '../widgets/wishlist_content.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96),
        child: WishlistAppbar(isPage: true),
      ),
      body: WishlistContent(),
    );
  }
}
