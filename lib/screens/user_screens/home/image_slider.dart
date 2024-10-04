import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/extensions/screen_size.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 200, // Use a fixed height or context.getHeight
        width: double.infinity,
        child: ImageSlideshow(
          indicatorColor: AppConstants.mainWhite,
          indicatorBackgroundColor: const Color(0xff717171),
          autoPlayInterval: 7000,
          isLoop: true,
          children: [
            Image.asset(
              'assets/images/image_slider_1.png',
              fit: BoxFit.fill,
            ),
            Image.asset(
              'assets/images/Advertising.png',
              fit: BoxFit.fill,
            ),
            Image.asset(
              'assets/images/group_box.png',
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
