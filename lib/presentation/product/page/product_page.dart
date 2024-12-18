import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/core/configs/assets/app_images.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
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
    return BlocProvider(
      create: (context) => ProductBloc()..add(OnGetProduct(params: widget.id)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(96),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    color: AppColors.transparent,
                    shape: CircleBorder(),
                    child: Ink(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => context.pop(),
                        customBorder: CircleBorder(),
                        hoverColor: AppColors.black.withOpacity(0.2),
                        splashColor: AppColors.black.withOpacity(0.2),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppIcons.arrowLeft,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
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
                        shape: CircleBorder(),
                        child: Ink(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () => context.push(AppRoutes.search),
                            customBorder: CircleBorder(),
                            hoverColor: AppColors.black.withOpacity(0.2),
                            splashColor: AppColors.black.withOpacity(0.2),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                AppIcons.magnifyingGlass,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  AppColors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      HorizontalSpacer(width: 4),
                      Material(
                        color: AppColors.transparent,
                        shape: CircleBorder(),
                        child: Ink(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () => context.push(AppRoutes.cart),
                            customBorder: CircleBorder(),
                            hoverColor: AppColors.black.withOpacity(0.2),
                            splashColor: AppColors.black.withOpacity(0.2),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: SvgPicture.asset(
                                AppIcons.shoppingCart,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          decoration: BoxDecoration(
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
                      border: Border.all(color: AppColors.black, width: 0.1)),
                  child: InkWell(
                    onTap: () => context.push(AppRoutes.customerService),
                    borderRadius: BorderRadius.circular(4),
                    hoverColor: AppColors.black.withOpacity(0.2),
                    splashColor: AppColors.black.withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: SvgPicture.asset(
                        AppIcons.chat,
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          AppColors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              HorizontalSpacer(width: 16),
              Material(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(4),
                child: Ink(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColors.black, width: 0.1)),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(4),
                    hoverColor: AppColors.black.withOpacity(0.2),
                    splashColor: AppColors.black.withOpacity(0.2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.shoppingCart,
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              AppColors.neutral600,
                              BlendMode.srcIn,
                            ),
                          ),
                          HorizontalSpacer(width: 8),
                          Text(
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
              HorizontalSpacer(width: 16),
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
                      onTap: () => context.push(AppRoutes.payment),
                      borderRadius: BorderRadius.circular(4),
                      hoverColor: AppColors.white.withOpacity(0.2),
                      splashColor: AppColors.white.withOpacity(0.2),
                      child: Padding(
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
                    padding: EdgeInsets.symmetric(
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
                        HorizontalSpacer(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 226,
                                  child: Text(
                                    '${state.product.reviews[index].userName!}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
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
                            VerticalSpacer(height: 4),
                            Text(
                              'Varian Abu-abu',
                              style: TextStyle(
                                color: AppColors.neutral500,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            VerticalSpacer(height: 8),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 152,
                              child: Text(
                                '${state.product.reviews[index].comment}',
                                style: TextStyle(
                                  color: AppColors.neutral500,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            VerticalSpacer(height: 12),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 152,
                              child: Text(
                                DateFormat("dd MMMM yyyy")
                                    .format(state.product.reviews[index].date!),
                                style: TextStyle(
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
                              padding: EdgeInsets.symmetric(
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
                                style: TextStyle(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  state.product.name!,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                Material(
                                  color: AppColors.transparent,
                                  shape: CircleBorder(),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: InkWell(
                                      onTap: () {},
                                      customBorder: CircleBorder(),
                                      splashColor:
                                          AppColors.black.withOpacity(0.2),
                                      hoverColor:
                                          AppColors.black.withOpacity(0.2),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: SvgPicture.asset(
                                          AppIcons.heart,
                                          height: 24,
                                          width: 24,
                                          colorFilter: ColorFilter.mode(
                                            AppColors.black,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            VerticalSpacer(height: 4),
                            Row(
                              children: <Widget>[
                                SvgPicture.asset(
                                  AppIcons.starFilled,
                                  height: 16,
                                  width: 16,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.amber500,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                HorizontalSpacer(width: 4),
                                Text(
                                  '${state.product.rating.toString()} (${state.product.reviews.length.toString()}) | Terjual ${state.product.sold.toString()}',
                                  style: TextStyle(
                                    color: AppColors.neutral500,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Text(
                              'Rp. ${state.product.price.toString()}',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            VerticalSpacer(height: 8),
                            Divider(
                              color: AppColors.neutral300,
                              thickness: 2,
                            ),
                            VerticalSpacer(height: 8),
                            Text(
                              'Pilihan Warna',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            VerticalSpacer(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 12,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              runAlignment: WrapAlignment.center,
                              alignment: WrapAlignment.start,
                              children: List.generate(
                                state.product.colorName.length,
                                (index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.neutral100,
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                          color: AppColors.black, width: 0.1),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16,
                                          width: 16,
                                          decoration: BoxDecoration(
                                            color: stringToColor(
                                                state.product.color[index]),
                                            border: Border.all(
                                              color: AppColors.black,
                                              width: 0.1,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        HorizontalSpacer(width: 8),
                                        Text(
                                          '${state.product.colorName[index]}',
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            VerticalSpacer(height: 8),
                            Divider(
                              color: AppColors.neutral300,
                              thickness: 2,
                            ),
                            Text(
                              'Ukuran Bingkai',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 6),
                            Divider(
                              color: AppColors.neutral300,
                              thickness: 2,
                            ),
                            Text(
                              'Detail Bingkai',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
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
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 6),
                            Divider(
                              color: AppColors.neutral300,
                              thickness: 2,
                            ),
                            Text(
                              'Deskripsi',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            VerticalSpacer(height: 6),
                            Text(
                              '${state.product.description}',
                              style: TextStyle(
                                color: AppColors.neutral500,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            VerticalSpacer(height: 6),
                            Divider(
                              color: AppColors.neutral300,
                              thickness: 2,
                            ),
                            VerticalSpacer(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Review Pembeli',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.push(
                                    AppRoutes.productReview,
                                    extra: widget.id,
                                  ),
                                  child: Text(
                                    'Lihat Semua',
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpacer(height: 16),
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

            return SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
