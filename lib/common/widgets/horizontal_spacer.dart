import 'package:flutter/material.dart';

class HorizontalSpacer extends StatelessWidget {
  final double width;

  const HorizontalSpacer({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
