import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../common/bloc/auth_bloc.dart';
import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../unauthenticated/page/unauthenticated_page.dart';
import '../bloc/transaction_bloc.dart';
import '../bloc/transaction_product_bloc.dart';
import 'empty_transaction.dart';

class TransactionContent extends StatelessWidget {
  const TransactionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => TransactionBloc()),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: AuthBloc()..add(GetToken()),
        builder: (context, state) {
          if (state is UnauthenticatedState) {
            return const UnauthenticatedPage();
          }

          if (state is AuthenticatedState) {
            return BlocBuilder<TransactionBloc, TransactionState>(
              bloc: TransactionBloc()..add(OnGetTransactions()),
              builder: (context, state) {
                if (state is TransactionLoadedState) {
                  if (state.transactions.isEmpty) {
                    return const EmptyTransaction();
                  } else {
                    return SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Text(
                              '${state.transactions.length} transaksi ditemukan',
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
                                BlocProvider.of<TransactionBloc>(context)
                                    .add(OnGetTransactions());
                              },
                              child: ListView.separated(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                itemCount: state.transactions.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 12,
                                    ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BlocProvider(
                                          create: (context) =>
                                              TransactionProductBloc()
                                                ..add(
                                                  OnGetTransactionProduct(
                                                    id: state
                                                        .transactions[index]
                                                        .items[0]
                                                        .productId!,
                                                  ),
                                                ),
                                          child: BlocBuilder<
                                              TransactionProductBloc,
                                              TransactionProductState>(
                                            builder: (context, state) {
                                              if (state
                                                  is TransactionProductSuccessState) {
                                                return Row(
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl: state
                                                          .product.images[1],
                                                      height: 80,
                                                      width: 80,
                                                      fit: BoxFit.fitWidth,
                                                      placeholder: (_, __) =>
                                                          SvgPicture.asset(
                                                        AppImages
                                                            .imagePlaceholder,
                                                        width: 88,
                                                        height: 88,
                                                      ),
                                                    ),
                                                    const HorizontalSpacer(
                                                      width: 24,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            state.product.name!,
                                                            style:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 14,
                                                            ),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }

                                              if (state
                                                  is TransactionProductFailedState) {
                                                return Text(state.message);
                                              }

                                              return CircularProgressIndicator();
                                            },
                                          ),
                                        ),
                                        const Divider(
                                          color: AppColors.neutral500,
                                          thickness: 1,
                                        ),
                                        const VerticalSpacer(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'No. Transaksi',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              '${state.transactions[index].id}',
                                              style: TextStyle(
                                                color: AppColors.neutral600,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        VerticalSpacer(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tanggal',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              DateFormat("dd MMMM yyyy").format(
                                                state.transactions[index].date!,
                                              ),
                                              style: TextStyle(
                                                color: AppColors.neutral600,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const VerticalSpacer(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Jumlah',
                                              style: TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              'Rp. ${state.transactions[index].totalAmount}',
                                              style: TextStyle(
                                                color: AppColors.neutral600,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return VerticalSpacer(
                                    height:
                                        index == state.transactions.length - 1
                                            ? 0
                                            : 16,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
