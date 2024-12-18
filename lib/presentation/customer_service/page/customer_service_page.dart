import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/horizontal_spacer.dart';
import '../../../common/widgets/vertical_spacer.dart';
import '../../../core/configs/assets/app_icons.dart';
import '../../../core/configs/assets/app_images.dart';
import '../../../core/configs/routes/app_routes.dart';
import '../../../core/configs/theme/app_colors.dart';

class CustomerServicePage extends StatefulWidget {
  const CustomerServicePage({super.key});

  @override
  State<CustomerServicePage> createState() => _CustomerServicePageState();
}

class _CustomerServicePageState extends State<CustomerServicePage> {
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _textEditingController = TextEditingController();

  var _list = [
    'Message 1',
    'Message 1',
    'Message 1',
    'Message 1',
    'Message 1',
    'Message 1',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = List.generate(
      growable: true,
      _list.length,
      (index) {
        return Row(
          mainAxisAlignment:
              index % 2 == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              margin:
                  EdgeInsets.only(bottom: index < _list.length - 1 ? 24 : 0),
              decoration: BoxDecoration(
                color: index % 2 == 0 ? AppColors.green100 : AppColors.white,
                border: Border.all(
                  color: AppColors.black,
                  width: 0.1,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                mainAxisAlignment: index % 2 == 0
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                crossAxisAlignment: index % 2 == 0
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: Text(
                      _list[index],
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  VerticalSpacer(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      '12.00 AM',
                      style: TextStyle(
                        color: AppColors.neutral400,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                Text(
                  'Customer Service',
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textEditingController,
                textInputAction: TextInputAction.send,
                minLines: 1,
                maxLines: 6,
                onSubmitted: (value) {
                  setState(() {
                    _list.add(value);
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                    _textEditingController.text = '';
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Ketik pesan...',
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            HorizontalSpacer(width: 16),
            Material(
              color: AppColors.transparent,
              borderRadius: BorderRadius.circular(4),
              child: Ink(
                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.black, width: 0.1),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _list.add(_textEditingController.text);
                      _scrollController
                          .jumpTo(_scrollController.position.maxScrollExtent);
                      _textEditingController.text = '';
                    });
                  },
                  borderRadius: BorderRadius.circular(4),
                  hoverColor: AppColors.white.withOpacity(0.2),
                  splashColor: AppColors.white.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.asset(
                      AppIcons.send,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
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
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(
                      color: AppColors.black,
                      width: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  'Hari Ini',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              VerticalSpacer(height: 16),
              ...chat,
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerServiceEmptyPage extends StatelessWidget {
  const CustomerServiceEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.customerService,
            width: 390,
          ),
          const VerticalSpacer(height: 16),
          const Text(
            'Selamat Datang di Customer Service',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const VerticalSpacer(height: 4),
          const Text(
            'Tanyakan pertanyaan yang belum terjawab, keluhkan juga masalah yang belum selesai!',
            style: TextStyle(
              color: AppColors.neutral500,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
