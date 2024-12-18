import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassify_flutter/common/widgets/vertical_spacer.dart';
import 'package:glassify_flutter/core/configs/assets/app_images.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

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
                HorizontalSpacer(width: 16),
                Expanded(
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Pengambilan Barang',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    VerticalSpacer(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.mapPin,
                          width: 24,
                          height: 24,
                        ),
                        HorizontalSpacer(width: 4),
                        Text(
                          'Optik Glassify - Kota Malang',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpacer(height: 4),
                    Text(
                      'Alamat Pengambilan BarangAlamat Pengambilan BarangAlamat Pengambilan BarangAlamat Pengambilan BarangAlamat Pengambilan BarangAlamat Pengambilan BarangAlamat Pengambilan BarangAlamat Pengambilan Barang',
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
              VerticalSpacer(height: 24),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Barang',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    VerticalSpacer(height: 16),
                    Column(
                      children: List.generate(
                        5,
                        (index) {
                          return Container(
                            margin:
                                EdgeInsets.only(bottom: index == 4 ? 0 : 20),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.amber500,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  width: 88,
                                  height: 88,
                                ),
                                HorizontalSpacer(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'ItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItemItem $index',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      VerticalSpacer(height: 4),
                                      Text(
                                        'Varian Abu abu',
                                        style: TextStyle(
                                          color: AppColors.neutral500,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 14,
                                        ),
                                      ),
                                      VerticalSpacer(height: 4),
                                      Text(
                                        '2 x Rp.4000000',
                                        style: TextStyle(
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              VerticalSpacer(height: 24),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
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
                    VerticalSpacer(height: 16),
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
                                    HorizontalSpacer(width: 16),
                                    Expanded(
                                      child: Text(
                                        _payments[index]['method']!,
                                        style: TextStyle(
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
                                          duration: Duration(milliseconds: 200),
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.white,
                                            border: Border.all(
                                              color: _selectedPayment == index
                                                  ? AppColors.black
                                                  : AppColors.neutral400,
                                              width: 2,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                            ),
                                          ),
                                        ),
                                        AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          height: 12,
                                          width: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _selectedPayment == index
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
                                      splashColor:
                                          AppColors.black.withOpacity(0.2),
                                      hoverColor:
                                          AppColors.black.withOpacity(0.2),
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
              VerticalSpacer(height: 24),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ringkasan Pembelian',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    VerticalSpacer(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Harga ($_selectedPayment Barang)',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Rp. 4000000',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpacer(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    VerticalSpacer(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Divider(
                      color: AppColors.neutral500,
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Tagihan',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Rp. 200023132',
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpacer(height: 16),
                    Material(
                      color: AppColors.transparent,
                      borderRadius: BorderRadius.circular(4),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: AppColors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: InkWell(
                          onTap: () => context.go(AppRoutes.paymentResult),
                          splashColor: AppColors.white.withOpacity(0.2),
                          hoverColor: AppColors.white.withOpacity(0.2),
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            child: Text(
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
        ),
      ),
    );
  }
}
