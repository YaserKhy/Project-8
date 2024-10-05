import 'package:flutter/material.dart';
import 'package:project8/constants/app_constants.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  const ProfileCard({super.key, required this.title, required this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppConstants.mainWhite,
        margin: const EdgeInsets.all(12),
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          borderSide: BorderSide.none
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Text(title,style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppConstants.textColor))
            ],
          ),
        )
      ),
    );
  }
}