import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/bloc/auth_bloc.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

import '../../search/bloc/product_history_bloc.dart';

import '../../unauthenticated/page/unauthenticated_page.dart';
import '../bloc/wishlist_bloc.dart';

import 'empty_wishlist.dart';
import 'wishlist_loading.dart';

class WishlistContent extends StatelessWidget {
  const WishlistContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(),
        ),
        BlocProvider(create: (context) => ProductHistoryBloc()),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: AuthBloc()..add(GetToken()),
        builder: (context, state) {
          if (state is UnauthenticatedState) {
            return const UnauthenticatedPage();
          }

          if (state is AuthenticatedState) {
            return BlocBuilder<WishlistBloc, WishlistState>(
              bloc: WishlistBloc()..add(OnGetWishlist()),
              builder: (context, state) {
                if (state is WishlistLoadedState) {
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 24.0,
                            left: 24.0,
                            top: 16.0,
                          ),
                          child: Text(
                            '${state.products.length} produk ditemukan',
                            style: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const VerticalSpacer(height: 16),
                        Expanded(
                          child: RefreshIndicator(
                            color: AppColors.black,
                            onRefresh: () async {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(GetToken());
                              BlocProvider.of<WishlistBloc>(context)
                                  .add(OnGetWishlist());
                            },
                            child: GridView.builder(
                              itemCount: state.products.length,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 16,
                              ),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: (1 / 1.96),
                              ),
                              itemBuilder: (context, index) => _buildGridTile(
                                context,
                                id: state.products[index].id!,
                                image: state.products[index].images.first,
                                name: state.products[index].name!,
                                price: state.products[index].price.toString(),
                                rating: state.products[index].rating.toString(),
                                reviewCount: state
                                    .products[index].reviews.length
                                    .toString(),
                                sold: state.products[index].sold.toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is WishlistEmptyState) {
                  return const EmptyWishlist();
                }

                return const WishlistLoading();
              },
            );
          }

          return const SizedBox.shrink();
        },
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
}
