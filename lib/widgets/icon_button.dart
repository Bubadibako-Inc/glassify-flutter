import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends StatelessWidget {
  final Function() onTap;
  final String icon;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final ColorFilter? colorFilter;

  const AppIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.height,
    this.width,
    this.padding,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: padding,
        alignment: Alignment.center,
        child: SvgPicture.asset(
          icon,
          colorFilter: colorFilter,
        ),
      ),
    );
  }
}
