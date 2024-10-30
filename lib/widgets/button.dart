import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final BoxDecoration? boxDecoration;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;

  const AppButton({
    super.key,
    required this.onTap,
    required this.child,
    this.boxDecoration,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        alignment: alignment,
        decoration: boxDecoration,
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
