import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/presentation/selfie/page/selfie_page.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';

import '../../../common/widgets/vertical_spacer.dart';
import '../../../common/widgets/horizontal_spacer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool _isAvailable = true;

  final TextEditingController _searchController = TextEditingController();

  int _tabIndex = 0;

  int _navbarIndex = 0;

  int _carouselIndex = 0;

  final List<String> _carouselItems = <String>[
    'https://images.unsplash.com/photo-1490911679664-99d34ae56d94?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1521677054946-20732413e20e?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1537290030920-ce0c15681846?q=80&w=1771&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1524686599807-08a16b19fefd?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1525546961789-d03d3236ae55?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  final List<String> _tabs = <String>[
    'Rekomendasi',
    'Populer',
    'Terlaris',
    'Koleksi Musim Dingin',
    'Kolesi Glassify x Banksy'
  ];

  final List<String> _navbarIcons = <String>[
    AppIcons.house,
    AppIcons.userFocus,
    AppIcons.heart,
    AppIcons.receipt,
  ];

  final List<String> _activeNavbarIcons = <String>[
    AppIcons.houseFilled,
    AppIcons.userFocusBold,
    AppIcons.heartFilled,
    AppIcons.receiptFilled,
  ];

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void _navigateToMenu() {
    context.push(AppRoutes.menu);
  }

  void _navigateToCart() {
    context.push(AppRoutes.cart);
  }

  @override
  Widget build(BuildContext context) {
    // final List<Widget> _appbarPages = [
    //   _buildHomeAppBarr(),
    //   _buildSelfieAppBarr(),
    //   _buildWishlistAppBarr(),
    //   _buildTransactionAppBar,
    // ];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: IndexedStack(
          index: _navbarIndex,
          children: [
            _buildHome(),
            const SelfiePage(),
            _buildWishlist(),
            _buildTransaction(),
          ],
        ),
      ),
      bottomNavigationBar: _buildNavigationBar(),
    );
  }

  Center _buildWishlist() {
    return const Center(
      child: Text('Wishlist Page'),
    );
  }

  Center _buildTransaction() {
    return const Center(
      child: Text('Transaction Page'),
    );
  }

  SingleChildScrollView _buildHome() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const VerticalSpacer(height: 24),
          _buildCarousel(_carouselItems[_carouselIndex]),
          const VerticalSpacer(height: 16),
          _buildCarouselIndicator(),
          const VerticalSpacer(height: 24),
          _buildTab(),
          const VerticalSpacer(height: 24),
          GridView.builder(
            itemCount: 12,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: (1 / 1.96),
            ),
            itemBuilder: (context, index) => _buildGridTile(),
          ),
          const VerticalSpacer(height: 16),
        ],
      ),
    );
  }

  Container _buildNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.black,
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
            spreadRadius: -0.8,
            offset: Offset.zero,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _navbarIcons.length,
          (index) {
            return _buildNavbarItem(
              _navbarIndex == index
                  ? _activeNavbarIcons[index]
                  : _navbarIcons[index],
              index,
            );
          },
        ),
      ),
    );
  }

  Material _buildNavbarItem(String icon, int index) {
    return Material(
      color: AppColors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: () {
          setState(() {
            _navbarIndex = index;
          });
        },
        customBorder: const CircleBorder(),
        hoverColor: AppColors.neutral600.withOpacity(0.2),
        splashColor: AppColors.neutral600.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            icon,
            width: 28,
            height: 28,
            colorFilter: const ColorFilter.mode(
              AppColors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  Container _buildGridTile() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.black,
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
            spreadRadius: -0.8,
            offset: Offset.zero,
          )
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 208,
                width: double.infinity,
                child: _isAvailable
                    ? Image.network(
                        'https://images.pexels.com/photos/27603433/pexels-photo-27603433/free-photo-of-mode-fashion-fesyen-wanita.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        width: double.infinity,
                        AppImages.imagePlaceholder,
                        fit: BoxFit.fill,
                      ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Eye-Catching Glasses Glasses Glasses Glasses Glasses Glasses',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const VerticalSpacer(height: 4),
                    const Text(
                      'Rp450.000',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const VerticalSpacer(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppIcons.starFilled,
                          colorFilter: const ColorFilter.mode(
                            AppColors.amber500,
                            BlendMode.srcIn,
                          ),
                          height: 14,
                          width: 14,
                        ),
                        const HorizontalSpacer(width: 4),
                        const Expanded(
                          child: Text(
                            '5.0 (15k) | Terjual 1003640k',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.neutral500,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned.fill(
            child: Material(
              color: AppColors.transparent,
              child: InkWell(
                onTap: () {},
                hoverColor: AppColors.neutral600.withOpacity(0.2),
                splashColor: AppColors.neutral600.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: AppColors.black,
            blurRadius: 1,
            blurStyle: BlurStyle.outer,
            spreadRadius: -0.8,
            offset: Offset.zero,
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(14),
                  child: SvgPicture.asset(
                    AppIcons.magnifyingGlass,
                    height: 16,
                    width: 16,
                  ),
                ),
                hintText: 'Cari kacamata impianmu',
              ),
            ),
          ),
          const HorizontalSpacer(width: 16),
          GestureDetector(
            onTap: _navigateToCart,
            child: SvgPicture.asset(
              AppIcons.shoppingCart,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
          const HorizontalSpacer(width: 16),
          GestureDetector(
            onTap: _navigateToMenu,
            child: SvgPicture.asset(
              AppIcons.list,
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.black,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildCarousel(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: AppColors.black,
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              spreadRadius: -0.8,
              offset: Offset.zero,
            )
          ],
        ),
      ),
    );
  }

  Row _buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _carouselItems.length,
        (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _carouselIndex = index;
              });
            },
            child: Container(
              margin: EdgeInsets.only(
                right: _carouselItems.length - 1 == index ? 0 : 8,
              ),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _carouselIndex == index
                    ? AppColors.neutral500
                    : AppColors.white,
                shape: BoxShape.circle,
                border: _carouselIndex == index
                    ? null
                    : Border.all(
                        style: BorderStyle.solid,
                        color: AppColors.neutral500,
                        width: 2,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView _buildTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          _tabs.length,
          (index) {
            return Container(
              margin: const EdgeInsets.only(right: 12),
              child: _buildTabItem(
                _tabs[index],
                index,
              ),
            );
          },
        ),
      ),
    );
  }

  Material _buildTabItem(String text, int index) {
    return Material(
      color: AppColors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: _tabIndex == index ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: AppColors.black,
            width: 0.1,
          ),
        ),
        child: InkWell(
          onTap: () {
            setState(() {
              _tabIndex = index;
            });
          },
          hoverColor: _tabIndex == index
              ? AppColors.neutral600.withOpacity(0.2)
              : AppColors.neutral200.withOpacity(0.2),
          splashColor: _tabIndex == index
              ? AppColors.neutral600.withOpacity(0.2)
              : AppColors.neutral200.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Text(
              text,
              style: TextStyle(
                color:
                    _tabIndex == index ? AppColors.white : AppColors.neutral500,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
