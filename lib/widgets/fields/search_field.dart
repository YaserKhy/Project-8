import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class SearchField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData prefixIcon;
  const SearchField({super.key,required this.title,required this.controller,required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffF7F6F4),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          constraints: const BoxConstraints(minHeight: 43, maxWidth: 400),
          prefixIcon: Icon(prefixIcon,color: AppConstants.subTextColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide: BorderSide.none),
          hintText: title,
          hintStyle: const TextStyle(
            fontFamily: "Average",
            color: AppConstants.subTextColor,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }
}
