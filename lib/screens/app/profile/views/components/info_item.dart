import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';

class InfoItemTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback callback;
  final bool showDivider;
  const InfoItemTile({
    Key? key,
    required this.title,
    required this.callback,
    required this.subtitle,
    required this.showDivider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: callback,
      child: SizedBox(
        // padding: const EdgeInsets.all(18),
        // height: 54,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              text: title,
              size: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
            SizedBox(height: size.height * 0.01),
            CText(
              text: subtitle,
              size: 15,
              fontWeight: FontWeight.normal,
              color: const Color(0xFFB5BBC9),
            ),
            SizedBox(height: size.height * 0.02),
            showDivider ? const Divider() : const SizedBox(),
            SizedBox(height: size.height * 0.04),
          ],
        ),
      ),
    );
  }
}
