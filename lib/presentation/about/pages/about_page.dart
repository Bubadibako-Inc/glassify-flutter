import 'package:flutter/material.dart';

import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../widgets/about_appbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(96),
        child: AboutAppbar(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kontributor',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            VerticalSpacer(height: 8),
            const Text(
              'Ahmad Khoirul Falah',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            VerticalSpacer(height: 4),
            const Text(
              'Azka Annasiyya Haris',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            VerticalSpacer(height: 4),
            const Text(
              'Fadly Nugraha Jati',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            VerticalSpacer(height: 4),
            const Text(
              'Hilmi Irfan Naafi\'udin',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
