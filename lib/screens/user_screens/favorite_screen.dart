import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/widgets/other/page_title.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const PageTitle(title: "Favorites"),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 130,
                width: 420,
                decoration: BoxDecoration(
                    color: const Color(0xffF7F6F4),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 170,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 232, 231, 231),
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(
                            "assets/images/default_profile_img.png"),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Aligns text to the left
                        // mainAxisAlignment: MainAxisAlignment
                        //     .center, // Vertically centers the text
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Cortado",
                            style:
                                TextStyle(fontSize: 22, fontFamily: "Average"),
                          ),
                          Text("20 SR",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "Average")),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.fireFlameCurved,
                                    size: 15,
                                    color: AppConstants.mainRed,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("20 Cal"),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite,
                                      color: AppConstants.mainRed))
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
