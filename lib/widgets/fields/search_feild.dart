import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class SearchField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final IconData prefixIcon;
  const SearchField(
      {super.key,
      required this.title,
      required this.controller,
      required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              prefixIcon,
              color: Color(0xff525252),
            ),
            hintText: title,
            hintStyle: const TextStyle(
                color: Color(0xff525252), fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints(minHeight: 43, maxWidth: 400),
            filled: true,
            fillColor: const Color(0xffF7F6F4),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none)),
        controller: controller,
      ),
    );
  }
}
