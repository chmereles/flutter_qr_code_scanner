import 'package:flutter/material.dart';
import 'package:qr_code_scanner/buttons/custom_button_widget.dart';

class CustomButtonIconWidget extends StatelessWidget {
  const CustomButtonIconWidget({
    Key? key,
    required this.title,
    required this.onTap,
    required this.iconData,
    this.subtitle,
    this.iconColor,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final Color? iconColor;
  final String? subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return CustomButtonWidget(
      onTap: onTap,
      cardChild: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              iconData,
              color: iconColor,
              size: 30,
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: subtitle != null ? Text(subtitle!) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
