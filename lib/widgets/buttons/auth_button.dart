import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  const AuthButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        backgroundColor: AppConstants.mainRed,
        fixedSize: const Size(235, 41)
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 16,
          color: AppConstants.mainWhite
        )
      )
    );
  }
}