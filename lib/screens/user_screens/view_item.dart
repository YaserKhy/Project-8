import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';

class ViewItem extends StatelessWidget {
  const ViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstants.mainBgColor,
        appBar: AppBar(
          backgroundColor: AppConstants.mainlightBlue,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppConstants.mainWhite,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_border_rounded,
                    color: AppConstants.mainWhite,
                    size: 28,
                  )),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: 300.0,
                    color: AppConstants.mainlightBlue,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            height: 30,
                            width: 250,
                          ),
                          Image.asset('assets/images/stars.png'),
                        ],
                      ),
                      Image.asset(
                        'assets/images/black_coffee.png', // Replace with the coffee image
                        height: 190,
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Iced V60',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Average',
                                color: AppConstants.textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.fireFlameCurved,
                              size: 15,
                              color: AppConstants.mainRed,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '6 Cal.',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Average',
                                color: AppConstants.textColor,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '13 SAR',
                              style: TextStyle(
                                fontFamily: 'Average',
                                color: AppConstants.textColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'A delightful coffee brewing method that combines the clarity and complexity of pour-over coffee with the refreshing chill of iced beverages.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppConstants.textColor,
                            fontFamily: 'Average',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.mainBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "add to cart",
                          style: TextStyle(color: AppConstants.mainWhite),
                        )),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {},
                  ),
                  const Text('1', style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ));
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height * 0.7);
    var controlPoint = Offset(size.width / 2, size.height);
    var endPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
