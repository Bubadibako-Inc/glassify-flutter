import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../search/bloc/product_history_bloc.dart';
import '../bloc/search_result_bloc.dart';

class SearchResultPage extends StatefulWidget {
  final String query;
  const SearchResultPage({super.key, required this.query});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isEmpty = false;

  @override
  void initState() {
    _controller.text = widget.query;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchResultBloc()
            ..add(
              OnGetSearchResult(
                params: {"query": widget.query},
              ),
            ),
        ),
        BlocProvider(
          create: (context) => ProductHistoryBloc(),
        ),
      ],
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(96),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.black,
                    width: 0.1,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Material(
                    color: AppColors.transparent,
                    shape: const CircleBorder(),
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => context.pop(),
                        customBorder: const CircleBorder(),
                        hoverColor: AppColors.black.withOpacity(0.2),
                        splashColor: AppColors.black.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppIcons.arrowLeft,
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                              AppColors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  HorizontalSpacer(width: 16),
                  Expanded(
                    child: Builder(builder: (context) {
                      return TextField(
                        controller: _controller,
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            BlocProvider.of<SearchResultBloc>(context).add(
                              OnGetSearchResult(
                                params: {"name": query},
                              ),
                            );
                          }
                        },
                        onChanged: (query) {
                          query.isEmpty
                              ? setState(() {
                                  _isEmpty = true;
                                })
                              : setState(() {
                                  _isEmpty = false;
                                });
                        },
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(14),
                            child: SvgPicture.asset(
                              AppIcons.magnifyingGlass,
                              height: 16,
                              width: 16,
                            ),
                          ),
                          suffixIcon: _isEmpty
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.all(14),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _controller.text = '';
                                        _isEmpty = true;
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      AppIcons.xCircle,
                                      height: 16,
                                      width: 16,
                                    ),
                                  ),
                                ),
                          hintText: 'Cari kacamata impianmu',
                        ),
                      );
                    }),
                  ),
                  HorizontalSpacer(width: 16),
                  Material(
                    color: AppColors.transparent,
                    shape: const CircleBorder(),
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => context.push(AppRoutes.cart),
                        customBorder: const CircleBorder(),
                        hoverColor: AppColors.black.withOpacity(0.2),
                        splashColor: AppColors.black.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<SearchResultBloc, SearchResultState>(
            builder: (context, state) {
              if (state is SearchResultSuccessState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 16,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '//${state.products.length} produk ditemukan',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          HorizontalSpacer(width: 16),
                          Row(
                            children: [
                              Material(
                                color: AppColors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: AppColors.black, width: 0.1)),
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(4),
                                    hoverColor:
                                        AppColors.black.withOpacity(0.2),
                                    splashColor:
                                        AppColors.black.withOpacity(0.2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SvgPicture.asset(
                                        AppIcons.sort,
                                        width: 24,
                                        height: 24,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.neutral600,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              HorizontalSpacer(width: 8),
                              Material(
                                color: AppColors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: AppColors.black, width: 0.1)),
                                  child: InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(4),
                                    hoverColor:
                                        AppColors.black.withOpacity(0.2),
                                    splashColor:
                                        AppColors.black.withOpacity(0.2),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: SvgPicture.asset(
                                        AppIcons.filter,
                                        width: 24,
                                        height: 24,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.neutral600,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
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
                        itemBuilder: (context, index) => Container(
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
                                      child: Image.network(
                                        'https://images.pexels.com/photos/27603433/pexels-photo-27603433/free-photo-of-mode-fashion-fesyen-wanita.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                                        fit: BoxFit.cover,
                                      )),
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          state.products[index].name!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const VerticalSpacer(height: 4),
                                        Text(
                                          'Rp ${state.products[index].price.toString()}',
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              AppIcons.starFilled,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                AppColors.amber500,
                                                BlendMode.srcIn,
                                              ),
                                              height: 14,
                                              width: 14,
                                            ),
                                            const HorizontalSpacer(width: 4),
                                            Expanded(
                                              child: Text(
                                                '${state.products[index].rating.toString()} (${state.products[index].reviews.length.toString()}) | Terjual ${state.products[index].sold.toString()}',
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
                                    onTap: () {
                                      BlocProvider.of<ProductHistoryBloc>(
                                              context)
                                          .add(
                                        OnSetProductHistory(
                                          id: state.products[index].id!,
                                        ),
                                      );
                                      context.push(
                                        AppRoutes.product,
                                        extra: state.products[index].id!,
                                      );
                                    },
                                    hoverColor:
                                        AppColors.neutral600.withOpacity(0.2),
                                    splashColor:
                                        AppColors.neutral600.withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }

              if (state is SearchResultFailedState) {
                return Text(state.message);
              }

              return Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
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
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 4,
        ),
        itemBuilder: (_, __) {
          return Shimmer.fromColors(
            child: Container(
              width: 192,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: AppColors.white,
              ),
            ),
            baseColor: AppColors.neutral300,
            highlightColor: AppColors.neutral100,
          );
        },
        separatorBuilder: (_, __) {
          return HorizontalSpacer(width: 24);
        },
      ),
    );
  }
}
