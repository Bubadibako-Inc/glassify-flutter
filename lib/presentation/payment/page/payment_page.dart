import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/data/transaction/models/transaction_req_params.dart';
import 'package:glassify_flutter/presentation/payment/bloc/add_transaction_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../bloc/product_bloc.dart';

class PaymentPage extends StatefulWidget {
  final String id;

  const PaymentPage({super.key, required this.id});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPayment = 0;

  final List<Map<String, String>> _payments = [
    {
      'image': AppImages.briLogo,
      'method': 'Bank BRI',
    },
    {
      'image': AppImages.bcaLogo,
      'method': 'Bank BCA',
    },
    {
      'image': AppImages.bniLogo,
      'method': 'Bank BNI',
    },
    {
      'image': AppImages.mandiriLogo,
      'method': 'Bank Mandiri',
    },
    {
      'image': AppImages.danaLogo,
      'method': 'Dana',
    },
    {
      'image': AppImages.ovoLogo,
      'method': 'OVO',
    },
    {
      'image': AppImages.gopayLogo,
      'method': 'Gopay',
    },
  ];

  Future<void> _showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Memproses Pembayaran',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                VerticalSpacer(height: 16),
                CircularProgressIndicator(
                  color: AppColors.black,
                  strokeWidth: 4,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const HorizontalSpacer(width: 16),
                const Expanded(
                  child: Text(
                    'Pembayaran',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PaymentProductBloc()
              ..add(OnGetPaymentProduct(params: widget.id)),
          ),
          BlocProvider(
            create: (context) => AddTransactionBloc(),
          ),
        ],
        child: BlocListener<AddTransactionBloc, AddTransactionState>(
          listener: (context, state) {
            if (state is AddTransactionSuccessState) {
              context.go(AppRoutes.paymentResult, extra: state.id);
            }

            if (state is AddTransactionFailedState) {
              context.go(AppRoutes.paymentFailed);
            }

            if (state is AddTransactionLoadingState) {
              _showLoadingDialog(context);
            }
          },
          child: SafeArea(
            child: BlocBuilder<PaymentProductBloc, PaymentProductState>(
              builder: (context, state) {
                if (state is PaymentProductSuccessState) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Alamat Pengambilan Barang',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    AppIcons.mapPin,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const HorizontalSpacer(width: 4),
                                  const Text(
                                    'Optik Glassify - Kota Malang',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 4),
                              const Text(
                                'Jl. Merdeka No. 45, Kelurahan Blimbing, Kecamatan Blimbing, Kota Malang, Jawa Timur 65122',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                        const VerticalSpacer(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Daftar Barang',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 16),
                              Container(
                                child: Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: state.product.images[1],
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.fitWidth,
                                      placeholder: (_, __) => SvgPicture.asset(
                                        AppImages.imagePlaceholder,
                                        width: 88,
                                        height: 88,
                                      ),
                                    ),
                                    const HorizontalSpacer(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.product.name!,
                                            style: const TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const VerticalSpacer(height: 4),
                                          Text(
                                            'Rp. ${state.product.price.toString()}',
                                            style: const TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalSpacer(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Text(
                                  'Metode Pembayaran',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const VerticalSpacer(height: 16),
                              Column(
                                children: List.generate(
                                  _payments.length,
                                  (index) {
                                    return Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0,
                                            vertical: 16,
                                          ),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                _payments[index]['image']!,
                                                width: 40,
                                              ),
                                              const HorizontalSpacer(width: 16),
                                              Expanded(
                                                child: Text(
                                                  _payments[index]['method']!,
                                                  style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    width: 16,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.white,
                                                      border: Border.all(
                                                        color:
                                                            _selectedPayment ==
                                                                    index
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .neutral400,
                                                        width: 2,
                                                        strokeAlign: BorderSide
                                                            .strokeAlignOutside,
                                                      ),
                                                    ),
                                                  ),
                                                  AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    height: 12,
                                                    width: 12,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: _selectedPayment ==
                                                              index
                                                          ? AppColors.black
                                                          : AppColors.white,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: Material(
                                            color: AppColors.transparent,
                                            child: Ink(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _selectedPayment = index;
                                                  });
                                                },
                                                splashColor: AppColors.black
                                                    .withOpacity(0.2),
                                                hoverColor: AppColors.black
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const VerticalSpacer(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 24,
                          ),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ringkasan Pembelian',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const VerticalSpacer(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Harga',
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${state.product.price.toString()}',
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 2),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Biaya Aplikasi',
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rp. 2000',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 2),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Biaya Layanan',
                                    style: TextStyle(
                                      color: AppColors.neutral500,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rp. 1000',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: AppColors.neutral500,
                                thickness: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total Tagihan',
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${(state.product.price! + 3000).toString()}',
                                    style: const TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const VerticalSpacer(height: 16),
                              Material(
                                color: AppColors.transparent,
                                borderRadius: BorderRadius.circular(4),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: AppColors.black,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      BlocProvider.of<AddTransactionBloc>(
                                              context)
                                          .add(
                                        OnAddTransactionPressed(
                                          params: TransactionReqParams(
                                            productId: widget.id,
                                            quantity: 1,
                                          ),
                                        ),
                                      );
                                    },
                                    splashColor:
                                        AppColors.white.withOpacity(0.2),
                                    hoverColor:
                                        AppColors.white.withOpacity(0.2),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 12,
                                      ),
                                      child: const Text(
                                        'Bayar Sekarang',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is PaymentProductFailedState) {
                  return Center(
                    child: Text(state.message),
                  );
                }

                return const Center(
                  child: const CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
