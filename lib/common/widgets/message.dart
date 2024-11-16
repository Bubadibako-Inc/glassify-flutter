import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/horizontal_spacer.dart';

class Message extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final String icon;
  final Color iconColor;
  final String text;
  final TextStyle style;

  const Message(
      {super.key,
      required this.color,
      required this.borderColor,
      required this.icon,
      required this.iconColor,
      required this.text,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: borderColor,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(
              iconColor,
              BlendMode.srcIn,
            ),
          ),
          HorizontalSpacer(width: 8),
          Flexible(
            child: Text(
              text,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
