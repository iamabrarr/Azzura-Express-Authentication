import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountryCityPicker extends StatelessWidget {
  const CountryCityPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cont = Get.find<ButtonsController>();
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.widthMultiplier * 2,
          vertical: SizeConfig.heightMultiplier * 1),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            offset: const Offset(6, 6))
      ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: CSCPicker(
        flagState: CountryFlag.ENABLE,
        dropdownDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1)),
        selectedItemStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: SizeConfig.textMultiplier * 1.9,
            color: Colors.grey.shade500),
        disabledDropdownDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.grey.shade200,
            border: Border.all(color: Colors.grey.shade300, width: 1)),
        onCountryChanged: (value) {
          cont.country.value = value;
        },
        onStateChanged: (value) {
          cont.state.value = value ?? "Null";
        },
        onCityChanged: (value) {
          cont.city.value = value ?? "Null";
        },
      ),
    );
  }
}
