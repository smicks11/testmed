import 'package:flutter/material.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/utils/colors.dart';

class ItemTile extends StatelessWidget {
  final String itemName;
  final VoidCallback callback;
  final String? trailing;
  const ItemTile(
      {Key? key, required this.itemName, required this.callback, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: trailing == null ? callback : null,
      child: Container(
        padding: const EdgeInsets.all(18),
        height: 54,
        width: size.width,
        decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(curveRadius)),
        child: Row(
          children: [
            CText(
              text: itemName,
              size: 19,
              color: trailing != null ? const Color(0xFF78839C) : kTextColor,
              fontWeight: FontWeight.w600,
            ),
            const Spacer(),
            trailing != null
                ? CText(
                    text: "$trailing",
                    size: 15,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF78839C),
                  )
                : const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFFB5BBC9),
                  )
          ],
        ),
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String itemName;
  final VoidCallback callback;
  final String image;
  final bool? showTrailing;
  final IconData? icon;
  final Color? iconColor;
  const Item({
    Key? key,
    required this.itemName,
    required this.callback,
    required this.image,
    this.showTrailing = false,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.asset(image),
            const SizedBox(width: 20),
            CText(
              text: itemName,
              fontWeight: FontWeight.w600,
              size: 14,
              color: kTextColor,
            ),
            const Spacer(),
            showTrailing == true
                ? Icon(icon, color: iconColor)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
