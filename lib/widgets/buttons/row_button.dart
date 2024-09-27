import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class RowButton extends StatelessWidget {
  final String text;
  final String buttonText;
  final bool isBold;
  final Function()? onPressed;
  const RowButton({super.key, required this.text, required this.buttonText, this.isBold=false, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 15,
            color: Colors.white
          )
        ),
        TextButton(
          onPressed: onPressed,
          style: const ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size.zero),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 0)),
            alignment: Alignment.center
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 15,
              color: AppConstants.mainRed,
              fontWeight: isBold ? FontWeight.w600 : null
            )
          ),
        )
      ],
    );
  }
}