import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../common/widgets/horizontal_spacer.dart';

import '../../search/bloc/product_history_bloc.dart';
import '../../selfie/pages/selfie_page.dart';
import '../../selfie/widgets/selfie_appbar.dart';
import '../../transaction/widgets/transaction_appbar.dart';
import '../../transaction/widgets/transaction_content.dart';
import '../../wishlist/widgets/wishlist_appbar.dart';
import '../../wishlist/widgets/wishlist_content.dart';

import '../bloc/carousel_bloc.dart';
import '../bloc/navbar_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/best_seller_product_bloc.dart';
import '../bloc/latest_product_bloc.dart';
import '../widgets/home_appbar.dart';
import '../widgets/home_carousel.dart';
import '../widgets/home_carousel_indicator.dart';
import '../widgets/home_navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  final List<String> _carouselImages = <String>[
    'https://images.unsplash.com/photo-1490911679664-99d34ae56d94?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1521677054946-20732413e20e?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1689977807477-a579eda91fa2?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1537290030920-ce0c15681846?q=80&w=1771&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1524686599807-08a16b19fefd?q=80&w=1770&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    'https://images.unsplash.com/photo-1525546961789-d03d3236ae55?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
  ];

  final List<String> _inactiveIcons = <String>[
    AppIcons.house,
    AppIcons.userFocus,
    AppIcons.heart,
    AppIcons.receipt,
  ];

  final List<String> _activeIcons = <String>[
    AppIcons.houseFilled,
    AppIcons.userFocusBold,
    AppIcons.heartFilled,
    AppIcons.receiptFilled,
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc()..add(OnGetProducts()),
        ),
        BlocProvider(
          create: (context) => LatestProductBloc()..add(OnGetLatestProducts()),
        ),
        BlocProvider(
          create: (context) =>
              BestSellerProductBloc()..add(OnGetBestSellerProducts()),
        ),
        BlocProvider(create: (context) => ProductHistoryBloc()),
        BlocProvider(create: (context) => CarouselBloc()),
        BlocProvider(create: (context) => NavbarBloc()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(96),
            child: BlocBuilder<NavbarBloc, NavbarState>(
              builder: (context, state) {
                return IndexedStack(
                  index: BlocProvider.of<NavbarBloc>(context).state.index,
                  children: const [
                    HomeAppbar(),
                    SelfieAppbar(),
                    WishlistAppbar(isPage: false),
                    TransactionAppbar(isPage: false),
                  ],
                );
              },
            )),
        body: SafeArea(
          child: BlocBuilder<NavbarBloc, NavbarState>(
            builder: (context, state) {
              return IndexedStack(
                index: BlocProvider.of<NavbarBloc>(context).state.index,
                children: [
                  _buildHome(),
                  const SelfiePage(),
                  const WishlistContent(),
                  const TransactionContent(),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: HomeNavbar(
          activeIcons: _activeIcons,
          inactiveIcons: _inactiveIcons,
        ),
      ),
    );
  }

  SingleChildScrollView _buildHome() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeCarousel(
            pageController: _pageController,
            images: _carouselImages,
          ),
          const VerticalSpacer(height: 12),
          HomeCarouselIndicator(
            images: _carouselImages,
          ),
          const VerticalSpacer(height: 24),
          _buildTitle(title: 'Rekomendasi Buat Kamu'),
          const VerticalSpacer(height: 12),
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductSuccessState) {
                return SizedBox(
                  height: 344,
                  child: ListView.separated(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 4,
                    ),
                    itemBuilder: (_, index) {
                      return _buildGridTile(
                        context,
                        id: state.products[index].id!,
                        image: state.products[index].images[0],
                        name: state.products[index].name!,
                        price: state.products[index].price.toString(),
                        rating: state.products[index].rating.toString(),
                        reviewCount:
                            state.products[index].reviews.length.toString(),
                        sold: state.products[index].sold.toString(),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const HorizontalSpacer(width: 24);
                    },
                  ),
                );
              }

              if (state is ProductFailedState) {
                SizedBox(
                  height: 344,
                  child: Center(
                    child: Text(state.message.toString()),
                  ),
                );
              }

              return const LoadingCard();
            },
          ),
          const VerticalSpacer(height: 16),
          _buildTitle(title: 'Kacamata Terlaris'),
          const VerticalSpacer(height: 12),
          BlocBuilder<LatestProductBloc, LatestProductState>(
            builder: (context, state) {
              if (state is LatestProductSuccessState) {
                return SizedBox(
                  height: 344,
                  child: ListView.separated(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 4,
                    ),
                    itemBuilder: (_, index) {
                      return _buildGridTile(
                        context,
                        id: state.products[index].id!,
                        image: state.products[index].images[0],
                        name: state.products[index].name!,
                        price: state.products[index].price.toString(),
                        rating: state.products[index].rating.toString(),
                        reviewCount:
                            state.products[index].reviews.length.toString(),
                        sold: state.products[index].sold.toString(),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const HorizontalSpacer(width: 24);
                    },
                  ),
                );
              }

              if (state is LatestProductFailedState) {
                SizedBox(
                  height: 344,
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              }

              return const LoadingCard();
            },
          ),
          const VerticalSpacer(height: 16),
          _buildTitle(title: 'Kacamata Terbaru'),
          const VerticalSpacer(height: 12),
          BlocBuilder<BestSellerProductBloc, BestSellerProductState>(
            builder: (context, state) {
              if (state is BestSellerProductSuccessState) {
                return SizedBox(
                  height: 344,
                  child: ListView.separated(
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 4,
                    ),
                    itemBuilder: (_, index) {
                      return _buildGridTile(
                        context,
                        id: state.products[index].id!,
                        image: state.products[index].images[0],
                        name: state.products[index].name!,
                        price: state.products[index].price.toString(),
                        rating: state.products[index].rating.toString(),
                        reviewCount:
                            state.products[index].reviews.length.toString(),
                        sold: state.products[index].sold.toString(),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return const HorizontalSpacer(width: 24);
                    },
                  ),
                );
              }

              if (state is BestSellerProductFailedState) {
                SizedBox(
                  height: 344,
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              }

              return const LoadingCard();
            },
          ),
          const VerticalSpacer(height: 16),
        ],
      ),
    );
  }

  Widget _buildGridTile(
    BuildContext context, {
    required String id,
    required String image,
    required String name,
    required String price,
    required String rating,
    required String reviewCount,
    required String sold,
  }) {
    return Container(
      width: 192,
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
              CachedNetworkImage(
                imageUrl: image,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 208,
                placeholder: (_, __) {
                  return SizedBox(
                    height: 208,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      width: double.infinity,
                      AppImages.imagePlaceholder,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                errorWidget: (_, __, ___) {
                  return SizedBox(
                    height: 208,
                    width: double.infinity,
                    child: SvgPicture.asset(
                      width: double.infinity,
                      AppImages.imagePlaceholder,
                      fit: BoxFit.fill,
                    ),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    const VerticalSpacer(height: 4),
                    Text(
                      'Rp $price',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
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
                        Expanded(
                          child: Text(
                            '$rating ($reviewCount) | Terjual $sold',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
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
                onTap: () {
                  BlocProvider.of<ProductHistoryBloc>(context).add(
                    OnSetProductHistory(id: id),
                  );
                  context.push(
                    AppRoutes.product,
                    extra: id,
                  );
                },
                hoverColor: AppColors.neutral600.withOpacity(0.2),
                splashColor: AppColors.neutral600.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap: () => context.push(AppRoutes.searchResult, extra: ''),
            child: const Text(
              'Lihat Semua',
              style: TextStyle(
                color: AppColors.neutral600,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 344,
      child: ListView.separated(
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 4,
        ),
        itemBuilder: (_, __) {
          return Shimmer.fromColors(
            baseColor: AppColors.neutral300,
            highlightColor: AppColors.neutral100,
            child: Container(
              width: 192,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.white,
              ),
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const HorizontalSpacer(width: 24);
        },
      ),
    );
  }
}
