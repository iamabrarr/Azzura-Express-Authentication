import 'package:azzurra_express/constants/icons.dart';
import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/size_config.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.keyboardType})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPassword = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 4,
          vertical: SizeConfig.heightMultiplier * 0.3),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(6, 6))
      ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: widget.hintText == "Password" ||
                      widget.hintText == "Confirm Password"
                  ? isPassword
                  : false,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              style: const TextStyle(fontWeight: FontWeight.w500),
              scrollPadding: const EdgeInsets.all(0),
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500)),
            ),
          ),
          widget.hintText == "Password" || widget.hintText == "Confirm Password"
              ? IconButton(
                  onPressed: () {
                    isPassword = !isPassword;
                    setState(() {
                      
                    });
                  },
                  icon: Image.asset(
                    isPassword ? passwordEye : passwordEyeOff,
                    height: SizeConfig.heightMultiplier * 2.5,
                    color: Colors.grey.shade400,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
