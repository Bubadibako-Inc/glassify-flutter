import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../bloc/payment_result_bloc.dart';

class PaymentResultPage extends StatefulWidget {
  final String id;
  const PaymentResultPage({super.key, required this.id});

  @override
  State<PaymentResultPage> createState() => _PaymentResultPageState();
}

class _PaymentResultPageState extends State<PaymentResultPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PaymentResultBloc()..add(OnGetPaymentResult(id: widget.id)),
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
                  const Text(
                    'Bukti Transaksi',
                    style: TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const HorizontalSpacer(width: 16),
                  Material(
                    color: AppColors.transparent,
                    shape: const CircleBorder(),
                    child: Ink(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () => context.go(AppRoutes.home),
                        customBorder: const CircleBorder(),
                        hoverColor: AppColors.black.withOpacity(0.2),
                        splashColor: AppColors.black.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppIcons.x,
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
        body: BlocBuilder<PaymentResultBloc, PaymentResultState>(
          builder: (context, state) {
            if (state is PaymentResultSuccessState) {
              return SafeArea(
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppColors.black,
                        width: 0.1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppImages.circleSuccess,
                          height: 112,
                          width: 112,
                        ),
                        const VerticalSpacer(height: 16),
                        const Text(
                          'Pembayaran Berhasil!',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        const VerticalSpacer(height: 4),
                        Text(
                          'Rp. ${state.transaction.totalAmount.toString()}',
                          style: const TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const VerticalSpacer(height: 4),
                        const Text(
                          'Terima kasih telah mempercayai dan menggunakan layanan kami.',
                          style: TextStyle(
                            color: AppColors.neutral500,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const VerticalSpacer(height: 4),
                        const Divider(
                          color: AppColors.neutral500,
                        ),
                        const VerticalSpacer(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Nomor Transaksi',
                              style: TextStyle(
                                color: AppColors.neutral500,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              state.transaction.id!,
                              style: const TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacer(height: 4),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Metode Pembayaran',
                              style: TextStyle(
                                color: AppColors.neutral500,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Bank BNI',
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacer(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tanggal Pembayaran',
                              style: TextStyle(
                                color: AppColors.neutral500,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                DateFormat("dd MMMM yyyy")
                                    .format(state.transaction.date!),
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacer(height: 4),
                        const Divider(
                          color: AppColors.neutral500,
                        ),
                        const VerticalSpacer(height: 24),
                        Material(
                          color: AppColors.transparent,
                          borderRadius: BorderRadius.circular(4),
                          child: Ink(
                            decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: () => context.go(AppRoutes.home),
                              hoverColor: AppColors.white.withOpacity(0.2),
                              splashColor: AppColors.white.withOpacity(0.2),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                child: Text(
                                  'Kembali ke Beranda',
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
                      ],
                    ),
                  ),
                ),
              );
            }

            if (state is PaymentResultFailedState) {
              return Center(
                child: Text(state.message),
              );
            }

            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.black,
                strokeWidth: 4,
              ),
            );
          },
        ),
      ),
    );
  }
}
