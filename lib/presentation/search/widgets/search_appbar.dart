import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../bloc/query_history_bloc.dart';

class SearchAppbar extends StatelessWidget {
  const SearchAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
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
            const HorizontalSpacer(width: 16),
            Expanded(
              child: TextField(
                onSubmitted: (query) {
                  BlocProvider.of<QueryHistoryBloc>(context).add(
                    OnSetQueryHistory(query: query),
                  );
                  context.pop();
                  context.push(AppRoutes.searchResult, extra: query);
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
                  hintText: 'Cari kacamata impianmu',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
