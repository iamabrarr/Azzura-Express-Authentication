import 'package:azzurra_express/controllers/buttons_controller.dart';
import 'package:azzurra_express/utils/size_config.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneNumberInputField extends StatelessWidget {
  const PhoneNumberInputField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

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
          //COUNTRY CODE PICKER
          InkWell(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: true,
                countryListTheme: CountryListThemeData(
                  borderRadius: BorderRadius.circular(12),
                ),
                onSelect: (Country country) {
                  print('Select country: ${country.countryCode}');
                  Get.find<ButtonsController>().countryCode.value =
                      country.phoneCode;
                },
              );
            },
            child: SizedBox(
              width: SizeConfig.widthMultiplier * 18,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Obx(
                  () => Text(
                    "+${Get.find<ButtonsController>().countryCode.value}",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.textMultiplier * 1.8,
                        color: Colors.grey.shade500),
                  ),
                ),
                SizedBox(
                  width: SizeConfig.widthMultiplier * 1,
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey.shade500)
              ]),
            ),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 2,
          ),
          //TELEPHONE TEXTFIELD
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Phone Number",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500)),
            ),
          ),
        ],
      ),
    );
  }
}
