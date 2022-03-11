// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medfest/constants/const.dart';
import 'package:medfest/utils/colors.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String hint;
  final IconData prefixIcon;
  final String error;
  final String Function(String?) validFunction;
  final Function(String)? onSavedFunction;
  final bool? isPassword;
  const AuthTextField({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    required this.controller,
    required this.inputType,
    required this.error,
    required this.validFunction,
    this.onSavedFunction,
    this.isPassword = false,
    //required this.validator,
  }) : super(key: key);

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool obscureText;
  @override
  void initState() {
    obscureText = widget.isPassword == true ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validFunction,
      onChanged: widget.onSavedFunction,
      keyboardType: widget.inputType,
      showCursor: true,
      cursorColor: kPrimaryColor,
      obscureText: obscureText,
      //validator: validator,
      style: const TextStyle(
        color: kBlackColor,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle:
            const TextStyle(color: Colors.black54, fontWeight: FontWeight.normal
                // fontFamily: "Booing",
                ),
        errorStyle: TextStyle(
          fontSize: 10,
        ),
        suffixIcon: widget.isPassword == true
            ? IconButton(
                onPressed: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                icon: Icon(obscureText == true
                    ? Icons.remove_red_eye_rounded
                    : Icons.remove_red_eye_outlined),
              )
            : const SizedBox(),
        // prefixIcon: Icon(
        //   prefixIcon,
        //   color: kBlackColor,
        // ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curveRadius - 10),
            borderSide: const BorderSide(color: kTextFieldColor)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curveRadius - 10),
            borderSide: const BorderSide(color: kTextFieldColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curveRadius - 10),
            borderSide: const BorderSide(color: kPrimaryColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(curveRadius - 10),
            borderSide: const BorderSide(color: kTextFieldColor)),
      ),
    );
  }
}
