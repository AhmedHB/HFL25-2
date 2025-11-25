import 'package:flutter/material.dart';

class DisplayWidget extends StatelessWidget {
  final String text;
  final String? lastExpression;
  final double scale;

  const DisplayWidget({
    super.key = const Key("display"),
    required this.text,
    required this.lastExpression,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // display över vad som är inmattat hittils
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            lastExpression ?? "",
            style: TextStyle(
              color: Colors.white38,
              fontSize: 14 * scale,
            ),
          ),
        ),
        SizedBox(height: 12 * scale),

        // Huvud display
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24 * scale,
            vertical: 18 * scale,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40 * scale),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 32 * scale,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
