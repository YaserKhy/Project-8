import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class AuthField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const AuthField({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white,fontFamily: "Average", fontWeight: FontWeight.w300, fontSize: 20),),
          const SizedBox(height: 10,),
          TextFormField(
            decoration: InputDecoration(
              errorStyle: const TextStyle(fontFamily: "Average"),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              constraints: const BoxConstraints(minHeight: 43, maxWidth: 319),
              filled: true,
              fillColor: AppConstants.mainWhite.withOpacity(.73),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none
              )
            ),
            controller: controller,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (text){
              if(text!.isEmpty) {
                return "$title field is required";
              }
              if(title.toLowerCase()=='email' && !AppConstants.emailRegex.hasMatch(text)) {
                return "Enter a Valid email";
              }
              if(title.toLowerCase()=='phone number' && (text.substring(0,2)!="05" || text.length!=10)) {
                return "Enter a valid phone number";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}