import 'package:flutter/material.dart';

class AuthPhrase extends StatelessWidget {
  const AuthPhrase({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Take ", style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20, fontWeight: FontWeight.w700),),
                  Text("a coffee &", style: TextStyle(fontFamily: "Poppins",color: Colors.white, fontSize: 20),),
                ],
              ),
              Row(
                children: [
                  Text("Give ", style: TextStyle(fontFamily: "Poppins",color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),),
                  Text("me something", style: TextStyle(fontSize: 20,color: Colors.white, fontFamily: "Poppins"),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}