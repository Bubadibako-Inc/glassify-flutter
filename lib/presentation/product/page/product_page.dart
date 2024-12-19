import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../common/bloc/auth_bloc.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../data/user/models/wishlist_req_params.dart';
import '../bloc/add_wishlist_bloc.dart';
import '../bloc/product_bloc.dart';

Color stringToColor(String colorString) {
  // Ensure the string starts with a '#'
  if (!colorString.startsWith('#')) {
    throw ArgumentError('Color string must start with #');
  }
  // Remove the '#' and parse the hex string
  final hexCode = colorString.substring(1);
  // Add the alpha channel (0xFF) for full opacity
  final color = Color(int.parse('FF$hexCode', radix: 16));
  return color;
}

class ProductPage extends StatefulWidget {
  final String id;
  const ProductPage({super.key, required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ProductBloc()..add(OnGetProduct(params: widget.id)),
        ),
        BlocProvider(
          create: (context) => AuthBloc()..add(GetToken()),
        ),
        BlocProvider(
          create: (context) => AddWishlistBloc(),
        ),
      ],
      child: BlocListener<AddWishlistBloc, AddWishlistState>(
        listener: (context, state) {
          if (state is AddWishlistSuccessState) {
            context.showFlash(
              barrierDismissible: true,
              barrierColor: AppColors.transparent,
              duration: Duration(seconds: 3),
              builder: (context, controller) => FlashBar(
                controller: controller,
                backgroundColor: AppColors.transparent,
                shadowColor: AppColors.transparent,
                elevation: 0,
                useSafeArea: true,
                forwardAnimationCurve: Curves.easeInCirc,
                reverseAnimationCurve: Curves.bounceIn,
                position: FlashPosition.top,
                content: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.green100,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.green300,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.check,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          AppColors.green500,
                          BlendMode.srcIn,
                        ),
                      ),
                      HorizontalSpacer(width: 8),
                      Flexible(
                        child: Text(
                          "Berhasil menambahkan produk ke wishlist",
                          style: TextStyle(
                            color: AppColors.green500,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is AddWishlistFailedState) {
            context.showFlash(
              barrierDismissible: true,
              barrierColor: AppColors.transparent,
              duration: Duration(seconds: 3),
              builder: (context, controller) => FlashBar(
                elevation: 0,
                controller: controller,
                backgroundColor: AppColors.transparent,
                shadowColor: AppColors.transparent,
                useSafeArea: true,
                forwardAnimationCurve: Curves.easeInCirc,
                reverseAnimationCurve: Curves.bounceIn,
                position: FlashPosition.top,
                content: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.red100,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: AppColors.red300,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.warningCircle,
                        height: 24,
                        width: 24,
                        colorFilter: ColorFilter.mode(
                          AppColors.red500,
                          BlendMode.srcIn,
                        ),
                      ),
                      HorizontalSpacer(width: 8),
                      Flexible(
                        child: Text(
                          state.message,
                          style: TextStyle(
                            color: AppColors.red500,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(96),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.black,
                      width: 0.1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    Row(
                      children: [
                        Material(
                          color: AppColors.transparent,
                          shape: const CircleBorder(),
                          child: Ink(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: InkWell(
                              onTap: () => context.push(AppRoutes.search),
                              customBorder: const CircleBorder(),
                              hoverColor: AppColors.black.withOpacity(0.2),
                              splashColor: AppColors.black.withOpacity(0.2),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset(
                                  AppIcons.magnifyingGlass,
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
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthenticatedState) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    border: Border(
                      top: BorderSide(
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
                        borderRadius: BorderRadius.circular(4),
                        child: Ink(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: AppColors.black, width: 0.1)),
                          child: InkWell(
                            onTap: () async {
                              BlocProvider.of<AddWishlistBloc>(context).add(
                                OnAddWishlistPressed(
                                  params:
                                      WishlistReqParams(productId: widget.id),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(4),
                            hoverColor: AppColors.black.withOpacity(0.2),
                            splashColor: AppColors.black.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.heart,
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.black,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const HorizontalSpacer(width: 8),
                                  const Text(
                                    'Tambah',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacer(width: 16),
                      Expanded(
                        child: Material(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: () => context.push(
                                AppRoutes.payment,
                                extra: widget.id,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              hoverColor: AppColors.white.withOpacity(0.2),
                              splashColor: AppColors.white.withOpacity(0.2),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Text(
                                  'Beli Sekarang',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          body: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductSuccessState) {
                final _reviews = List.generate(
                  state.product.reviews.length,
                  (index) {
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: index < state.product.reviews.length ? 12 : 0,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: AppColors.black,
                          width: 0.1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: state.product.reviews[index].userAvatar!,
                            height: 49,
                            width: 49,
                            placeholder: (_, __) => SvgPicture.asset(
                              AppImages.imagePlaceholder,
                            ),
                          ),
                          const HorizontalSpacer(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 226,
                                    child: Text(
                                      state.product.reviews[index].userName!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: List.generate(
                                      5,
                                      (idx) => SvgPicture.asset(
                                        idx + 1 <=
                                                state.product.reviews[index]
                                                    .rating!
                                            ? AppIcons.starFilled
                                            : AppIcons.star,
                                        height: 16,
                                        width: 16,
                                        colorFilter: ColorFilter.mode(
                                          idx + 1 <=
                                                  state.product.reviews[index]
                                                      .rating!
                                              ? AppColors.amber500
                                              : AppColors.black,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 152,
                                child: Text(
                                  '${state.product.reviews[index].comment}',
                                  style: const TextStyle(
                                    color: AppColors.neutral500,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              const VerticalSpacer(height: 12),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 152,
                                child: Text(
                                  DateFormat("dd MMMM yyyy").format(
                                      state.product.reviews[index].date!),
                                  style: const TextStyle(
                                    color: AppColors.neutral600,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              color: AppColors.white,
                              width: double.infinity,
                              height: 304,
                              child: PageView.builder(
                                itemCount: state.product.images.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    imageIndex = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return CachedNetworkImage(
                                    imageUrl: state.product.images[index],
                                    placeholder: (context, url) {
                                      return SvgPicture.asset(
                                        AppImages.imagePlaceholder,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              left: 12,
                              bottom: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(
                                    color: AppColors.black,
                                    width: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${imageIndex + 1} / ${state.product.images.length}',
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                state.product.name!,
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 4),
                              Row(
                                children: <Widget>[
                                  SvgPicture.asset(
                                    AppIcons.starFilled,
                                    height: 16,
                                    width: 16,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.amber500,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const HorizontalSpacer(width: 4),
                                  Text(
                                    '${state.product.rating.toString()} (${state.product.reviews.length.toString()}) | Terjual ${state.product.sold.toString()}',
                                    style: const TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Text(
                                'Rp. ${state.product.price.toString()}',
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                              const VerticalSpacer(height: 8),
                              const Divider(
                                color: AppColors.neutral300,
                                thickness: 2,
                              ),
                              const VerticalSpacer(height: 8),
                              // // const Text(
                              // //   'Pilihan Warna',
                              // //   style: TextStyle(
                              // //     color: AppColors.black,
                              // //     fontWeight: FontWeight.w700,
                              // //     fontSize: 16,
                              // //   ),
                              // // ),
                              // // const VerticalSpacer(height: 8),
                              // // Wrap(
                              // //   spacing: 8,
                              // //   runSpacing: 12,
                              // //   crossAxisAlignment: WrapCrossAlignment.center,
                              // //   runAlignment: WrapAlignment.center,
                              // //   alignment: WrapAlignment.start,
                              // //   children: List.generate(
                              // //     state.product.colorName.length,
                              // //     (index) {
                              // //       return Container(
                              // //         decoration: BoxDecoration(
                              // //           color: AppColors.neutral100,
                              // //           borderRadius: BorderRadius.circular(4),
                              // //           border: Border.all(
                              // //               color: AppColors.black, width: 0.1),
                              // //         ),
                              // //         padding: const EdgeInsets.symmetric(
                              // //           horizontal: 12,
                              // //           vertical: 4,
                              // //         ),
                              // //         child: Row(
                              // //           mainAxisSize: MainAxisSize.min,
                              // //           crossAxisAlignment:
                              // //               CrossAxisAlignment.center,
                              // //           children: [
                              // //             Container(
                              // //               height: 16,
                              // //               width: 16,
                              // //               decoration: BoxDecoration(
                              // //                 color: stringToColor(
                              // //                     state.product.color[index]),
                              // //                 border: Border.all(
                              // //                   color: AppColors.black,
                              // //                   width: 0.1,
                              // //                 ),
                              // //                 shape: BoxShape.circle,
                              // //               ),
                              // //             ),
                              // //             const HorizontalSpacer(width: 8),
                              // //             Text(
                              // //               state.product.colorName[index],
                              // //             ),
                              // //           ],
                              // //         ),
                              // //       );
                              // //     },
                              // //   ),
                              // // ),
                              // // const VerticalSpacer(height: 8),
                              // const Divider(
                              //   color: AppColors.neutral300,
                              //   thickness: 2,
                              // ),
                              const Text(
                                'Ukuran Bingkai',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Lebar Bingkai',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.frameWidth} mm',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Bridge',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.bridge} mm',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Lebar Lensa',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.lensWidth} mm',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Tinggi Lensa',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.lensHeight} mm',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Lebar Temple',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.templeLength} mm',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 6),
                              const Divider(
                                color: AppColors.neutral300,
                                thickness: 2,
                              ),
                              const Text(
                                'Detail Bingkai',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Ukuran',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.size}',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Material',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      state.product.material.join(", "),
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Berat',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.weight}',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Rim',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.rim}',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Bentuk Bingkai',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      '${state.product.shape}',
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Expanded(
                                    flex: 3,
                                    child: Text(
                                      'Fitur',
                                      style: TextStyle(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      state.product.features.join(", "),
                                      style: const TextStyle(
                                        color: AppColors.neutral500,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 6),
                              const Divider(
                                color: AppColors.neutral300,
                                thickness: 2,
                              ),
                              const Text(
                                'Deskripsi',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 6),
                              Text(
                                '${state.product.description}',
                                style: const TextStyle(
                                  color: AppColors.neutral500,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const VerticalSpacer(height: 6),
                              const Divider(
                                color: AppColors.neutral300,
                                thickness: 2,
                              ),
                              const VerticalSpacer(height: 6),
                              const Text(
                                'Review Pembeli',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 16),
                              ..._reviews,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              if (state is ProductFailedState) {
                return SafeArea(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              }

              return const SafeArea(
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
