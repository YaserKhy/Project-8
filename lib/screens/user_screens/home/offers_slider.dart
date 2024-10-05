import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:project8/constants/app_constants.dart';

class OffersSlider extends StatelessWidget {
  const OffersSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: ImageSlideshow(
          indicatorColor: AppConstants.mainWhite,
          indicatorBackgroundColor: const Color(0xff717171),
          autoPlayInterval: 7000,
          isLoop: true,
          children: [
            Image.asset('assets/images/image_slider_1.png',fit: BoxFit.fill,),
            Image.asset('assets/images/Advertising.png',fit: BoxFit.fill,),
            Image.asset('assets/images/group_box.png',fit: BoxFit.cover,),
          ],
        ),
      ),
    );
  }
}