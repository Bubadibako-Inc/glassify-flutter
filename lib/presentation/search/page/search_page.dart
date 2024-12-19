import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';

import '../bloc/product_history_bloc.dart';
import '../bloc/query_history_bloc.dart';
import '../widgets/search_appbar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => QueryHistoryBloc()..add(OnGetQueryHistory()),
        ),
        BlocProvider(
          create: (context) => ProductHistoryBloc()..add(OnGetProductHistory()),
        ),
      ],
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(96),
          child: SearchAppbar(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpacer(height: 16),
                BlocBuilder<QueryHistoryBloc, QueryHistoryState>(
                  builder: (_, state) {
                    if (state is QueryHistoryLoadedState) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'Riwayat Pencarian',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const VerticalSpacer(height: 8),
                BlocBuilder<QueryHistoryBloc, QueryHistoryState>(
                  builder: (_, state) {
                    if (state is QueryHistoryLoadedState) {
                      return Column(
                        children: List.generate(
                          state.queryHistory.length,
                          (index) {
                            return QueryHistoryItem(
                              query: state.queryHistory[index],
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const VerticalSpacer(height: 8),
                BlocBuilder<ProductHistoryBloc, ProductHistoryState>(
                  builder: (_, state) {
                    if (state is ProductHistoryLoadedState) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(
                          'Terakhir Dilihat',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const VerticalSpacer(height: 8),
                BlocBuilder<ProductHistoryBloc, ProductHistoryState>(
                  builder: (_, state) {
                    if (state is ProductHistoryLoadedState) {
                      return SizedBox(
                        height: 344,
                        child: ListView.separated(
                          itemCount: state.productHistory.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 4,
                          ),
                          itemBuilder: (_, index) {
                            return ProductHistoryItem(
                              id: state.productHistory[index].id!,
                              image: state.productHistory[index].images.first,
                              productName: state.productHistory[index].name!,
                              price:
                                  state.productHistory[index].price.toString(),
                              rating:
                                  state.productHistory[index].rating.toString(),
                              reviews: state
                                  .productHistory[index].reviews.length
                                  .toString(),
                              sold: state.productHistory[index].sold.toString(),
                            );
                          },
                          separatorBuilder: (_, __) {
                            return const HorizontalSpacer(width: 24);
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                const VerticalSpacer(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductHistoryItem extends StatelessWidget {
  final String id;
  final String image;
  final String productName;
  final String price;
  final String rating;
  final String reviews;
  final String sold;

  const ProductHistoryItem({
    super.key,
    required this.id,
    required this.image,
    required this.productName,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.sold,
  });

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: 208,
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (_, __) {
                    return SvgPicture.asset(AppImages.imagePlaceholder);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
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
                      price,
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
                            '$rating ($reviews) | Terjual $sold',
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

class QueryHistoryItem extends StatelessWidget {
  final String query;

  const QueryHistoryItem({
    super.key,
    required this.query,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.transparent,
      child: Ink(
        child: InkWell(
          onTap: () {
            BlocProvider.of<QueryHistoryBloc>(context).add(
              OnSetQueryHistory(query: query),
            );
            context.pop();
            context.push(AppRoutes.searchResult, extra: query);
          },
          splashColor: AppColors.black.withOpacity(0.2),
          hoverColor: AppColors.black.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  AppIcons.history,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black,
                    BlendMode.srcIn,
                  ),
                ),
                const HorizontalSpacer(width: 12),
                Text(
                  query,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
