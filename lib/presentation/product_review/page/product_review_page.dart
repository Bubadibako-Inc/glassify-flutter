import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

class ProductReviewPage extends StatefulWidget {
  final String id;
  const ProductReviewPage({super.key, required this.id});

  @override
  State<ProductReviewPage> createState() => _ProductReviewPageState();
}

class _ProductReviewPageState extends State<ProductReviewPage> {
  Widget _buildTitle(int length) {
    return Row(
      children: List.generate(
        5,
        (index) {
          return SvgPicture.asset(
            index + 1 <= length ? AppIcons.starFilled : AppIcons.star,
            height: 16,
            width: 16,
            colorFilter: ColorFilter.mode(
              index + 1 <= length ? AppColors.amber500 : AppColors.black,
              BlendMode.srcIn,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCheckboxList(
    BuildContext context,
    List<String> options,
    List<bool> checkedStates,
  ) {
    final _item = List.generate(
      options.length,
      (index) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Material(
              color: AppColors.transparent,
              child: Ink(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      checkedStates[index] = !checkedStates[index];
                    });
                  },
                  borderRadius: BorderRadius.circular(4),
                  hoverColor: AppColors.black.withOpacity(0.2),
                  splashColor: AppColors.black.withOpacity(0.2),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          checkedStates[index] == true
                              ? AppIcons.checkSquareFilled
                              : AppIcons.checkSquare,
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                            AppColors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        HorizontalSpacer(width: 16),
                        _buildTitle(index + 1),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._item,
        ],
      ),
    );
  }

  void _showFilterModal(
    BuildContext context,
    List<String> options,
    List<bool> values,
    List<String> selected,
  ) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
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
                          onTap: () => context.pop(),
                          customBorder: CircleBorder(),
                          hoverColor: AppColors.black.withOpacity(0.2),
                          splashColor: AppColors.black.withOpacity(0.2),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: SvgPicture.asset(
                              AppIcons.x,
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
              ),
              VerticalSpacer(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  color: AppColors.neutral400,
                  thickness: 1,
                ),
              ),
              VerticalSpacer(height: 8),
              Expanded(
                child: _buildCheckboxList(
                  context,
                  options,
                  values,
                ),
              ),
              VerticalSpacer(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Material(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: InkWell(
                      onTap: () {
                        for (int i = 0; i < values.length; i++) {
                          if (values[i]) {
                            if (selected.contains(options[i])) {
                              continue;
                            }
                            selected.add(options[i]);
                          } else {
                            if (selected.contains([options[i]])) {
                              selected.remove(options[i]);
                            }
                          }
                        }
                        setState(() {});
                        // Handle selected values here
                        print(selected); // For demonstration
                        context.pop();
                      },
                      borderRadius: BorderRadius.circular(4),
                      hoverColor: AppColors.white.withOpacity(0.2),
                      splashColor: AppColors.white.withOpacity(0.2),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: Text(
                          'Terapkan Filter',
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
      },
    );
  }

  void _showSortModal(BuildContext context) {
    List<bool> checkedStates = [false, false];
    List<String> options = ['Review terbaru', 'Review terlama'];

    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filter',
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
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
                          onTap: () => context.pop(),
                          customBorder: CircleBorder(),
                          hoverColor: AppColors.black.withOpacity(0.2),
                          splashColor: AppColors.black.withOpacity(0.2),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: SvgPicture.asset(
                              AppIcons.x,
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
              ),
              VerticalSpacer(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(
                  color: AppColors.neutral400,
                  thickness: 1,
                ),
              ),
              VerticalSpacer(height: 8),
              Expanded(
                child: _buildCheckboxList(
                  context,
                  options,
                  checkedStates,
                ),
              ),
              VerticalSpacer(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Material(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: InkWell(
                      onTap: () {
                        List<String> selectedValues = [];
                        for (int i = 0; i < checkedStates.length; i++) {
                          if (checkedStates[i]) {
                            selectedValues.add(options[i]);
                          }
                        }
                        // Handle selected values here
                        print(selectedValues); // For demonstration
                        context.pop();
                      },
                      borderRadius: BorderRadius.circular(4),
                      hoverColor: AppColors.white.withOpacity(0.2),
                      splashColor: AppColors.white.withOpacity(0.2),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: Text(
                          'Terapkan Pengurutan',
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<bool> checkedStates = [false, false, false, false, false];
    List<String> options = ['1', '2', '3', '4', '5'];
    List<String> selected = [];

    return Scaffold(
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
                HorizontalSpacer(width: 16),
                Text(
                  'Daftar Review',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
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
                      '123 review ditemukan',
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
                            onTap: () => _showSortModal(context),
                            borderRadius: BorderRadius.circular(4),
                            hoverColor: AppColors.black.withOpacity(0.2),
                            splashColor: AppColors.black.withOpacity(0.2),
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
                            color: selected.isEmpty
                                ? AppColors.white
                                : AppColors.black,
                            border: Border.all(
                              color: AppColors.black,
                              width: 0.1,
                            ),
                          ),
                          child: InkWell(
                            onTap: () => _showFilterModal(
                              context,
                              options,
                              checkedStates,
                              selected,
                            ),
                            borderRadius: BorderRadius.circular(4),
                            hoverColor: AppColors.black.withOpacity(0.2),
                            splashColor: AppColors.black.withOpacity(0.2),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SvgPicture.asset(
                                AppIcons.filter,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  selected.isEmpty
                                      ? AppColors.black
                                      : AppColors.white,
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
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 24),
                itemCount: 12,
                itemBuilder: (_, index) {
                  return Container(
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
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: AppColors.black,
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
                                      MediaQuery.of(context).size.width - 240,
                                  child: Text(
                                    'Nama User User User User User User User User User',
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
                                      idx + 1 <= 4
                                          ? AppIcons.starFilled
                                          : AppIcons.star,
                                      height: 16,
                                      width: 16,
                                      colorFilter: ColorFilter.mode(
                                        idx + 1 <= 4
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
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
                                '12 Novermber 2024',
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
                separatorBuilder: (_, __) {
                  return VerticalSpacer(height: 12);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
