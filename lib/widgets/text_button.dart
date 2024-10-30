import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  const AppTextButton({
    super.key,
    required this.onTap,
    required this.text,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
