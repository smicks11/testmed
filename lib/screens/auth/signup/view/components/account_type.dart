import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medfest/components/snack_bar.dart';
import 'package:medfest/components/text.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/screens/auth/signup/controller/signup_controller.dart';
import 'package:medfest/utils/app_spacing.dart';
import 'package:medfest/utils/colors.dart';

class AccountType extends StatefulWidget {
  const AccountType({Key? key}) : super(key: key);

  @override
  State<AccountType> createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  final List<String> _accountType = [
    "USER",
    "MEDICAL FACILITY",
  ];

  final List<String> _facilityType = [
    "CLINIC",
    "PHAMARCY",
    "HOSPITAL",
    "DIAGNOSTICS CENTRE"
  ];

  String? _selectedType;
  String? _selectedFacility;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var signupController = Get.find<SignupController>();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          kLargeVerticalSpacing,
          const Align(
            alignment: Alignment.centerLeft,
            child: CText(
              text: "Before your proceed 🙌",
              fontWeight: FontWeight.w700,
              size: 18,
              color: kBlackColor,
            ),
          ),
          const SizedBox(height: 14),
          const Align(
            alignment: Alignment.centerLeft,
            child: CText(
              text: "Select your preferred account Type",
              fontWeight: FontWeight.w400,
              size: 14,
              // color: kDarkGreyColor,
            ),
          ),
          //SizedBox(height: size.height * 0.04),
          kLargeVerticalSpacing,
          Center(
            child: DropdownButton(
              isExpanded: true,
              hint: const CText(
                  text: 'Please choose a type', size: 12,), // Not necessary for Option 1
              value: _selectedType,
              onChanged: (newValue) {
                setState(() {
                  _selectedType = newValue.toString();
                });
              },
              items: _accountType.map((type) {
                return DropdownMenuItem(
                  child: CText(text: type, size: 12,),
                  value: type,
                );
              }).toList(),
            ),
          ),
          _selectedType == "MEDICAL FACILITY"
              ? Center(
                  child: DropdownButton(
                    isExpanded: true,
                    hint: const CText(
                        text:
                            'Please select a facility type'), // Not necessary for Option 1
                    value: _selectedFacility,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedFacility = newValue.toString();
                      });
                    },
                    items: _facilityType.map((type) {
                      return DropdownMenuItem(
                        child: CText(text: type),
                        value: type,
                      );
                    }).toList(),
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          Obx(
            () => GestureDetector(
              onTap: () {
                try {
                  if (_selectedType == "USER") {
                    _selectedFacility = null;
                    signupController.signup(
                        accountType: _selectedType!,
                        facilityType: _selectedFacility);
                  } else if (_selectedType == "MEDICAL FACILITY") {
                    if (_selectedFacility != null) {
                      signupController.signup(
                          accountType: _selectedType!,
                          facilityType: _selectedFacility);
                    } else {
                      cToast(msg: "Select facility",color: Colors.red);
                    }
                  } else {
                    cToast(msg: "Select Account Type",color: Colors.red);
                  }
                } catch (e) {
                  cToast(
                      msg:
                          "Unable to establish connection, check your internet connection",color: Colors.red);
                }
              },
              child: Container(
                height: 70,
                width: size.width,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(curveRadius)),
                child: Center(
                  child: signupController.loading.value == true
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kWhiteColor),
                          strokeWidth: 1,
                        )
                      : const CText(
                          text: "Ride on 😍",
                          // fontWeight: FontWeight.w400,
                          size: 16,
                          color: kWhiteColor,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
