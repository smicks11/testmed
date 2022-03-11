import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medfest/utils/colors.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 55,
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: kDarkGreyColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search in Settings",
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            prefixIcon: const Icon(Entypo.magnifying_glass),
            hintStyle: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              wordSpacing: 2,
              color: kTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
