import 'package:azzurra_express/constants/colors.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.isBorder,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;
  final bool isBorder;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.heightMultiplier * 6,
        width: SizeConfig.widthMultiplier * 90,
        decoration: BoxDecoration(
            color: isBorder ? null : kPrimaryColor,
            border: isBorder ? Border.all(color: kPrimaryColor, width: 2) : null,
            boxShadow: isBorder
                ? null
                : [
                    BoxShadow(
                        color: kPrimaryColor.withOpacity(0.5), blurRadius: 6)
                  ],
            borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                fontWeight: FontWeight.w700,
                color: isBorder ? kPrimaryColor : Colors.white),
          ),
        ),
      ),
    );
  }
}
