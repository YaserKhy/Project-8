import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.title, required this.icon, this.onTap});
  final String title;
  final IconData icon;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
          margin: const EdgeInsets.all(12),
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide.none),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 12),
                Text(title,
                    style: const TextStyle(
                        color: AppConstants.textColor,
                        fontFamily: "Average",
                        fontSize: 18))
              ],
            ),
          )),
    );
  }
}
