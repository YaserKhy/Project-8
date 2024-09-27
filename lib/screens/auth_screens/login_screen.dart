import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project8/extensions/screen_size.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.red,
          body: Stack(
          children: [
            Image.asset('assets/images/auth_bg.png', height: context.getHeight(), fit: BoxFit.cover),
            SingleChildScrollView(
              child: Container(
                width: context.getWidth(),
                height: context.getHeight(),
                color: const Color(0xff4C6A7C).withOpacity(.8),
                child: Column(
                  children: [
                    const SizedBox(height: 74,),
                    Image.asset('assets/images/logo_title.png', width: 283, height: 71,),
                    const SizedBox(height: 159,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Email", style: TextStyle(color: Colors.white,fontFamily: "Poppins", fontWeight: FontWeight.w300, fontSize: 20),),
                          const SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xffE6E4DF).withOpacity(.73)),
                            width: 319,
                            height: 43,
                            child: TextFormField(
                              controller: TextEditingController(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 94,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        backgroundColor: const Color(0xff984a40),
                        fixedSize: const Size(235, 41)
                      ),
                      onPressed: ()=>log("You Pressed Login"),
                      child: const Text("Login", style: TextStyle(fontFamily: "Poppins", fontSize: 16, color: Color(0xffe6e4df)))
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account ? ", style: TextStyle(fontFamily: "Poppins", fontSize: 15, color: Colors.white),),
                        TextButton(
                          style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size.zero),padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 0)), alignment: Alignment.center),
                          onPressed: () => log("You Pressed guest"),
                          child: const Text("Sign up", style: TextStyle(fontFamily: "Poppins", fontSize: 15,color: Color(0xff984A40), fontWeight: FontWeight.w600),),
                        )
                      ],
                    ),
                    const SizedBox(height: 51,),
                    Stack(
                      children: [
                        Image.asset('assets/images/guest_stars.png'),
                        Column(
                          children: [
                            SizedBox(
                              height: 30,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Continue as ", style: TextStyle(fontFamily: "Poppins", fontSize: 15, color: Colors.white),),
                                  TextButton(
                                    style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size.zero),padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 0)), alignment: Alignment.center),
                                    onPressed: () => log("You Pressed guest"),
                                    child: const Text("guest", style: TextStyle(fontFamily: "Poppins", fontSize: 15,color: Color(0xff984A40))),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 87,),
                    const Padding(
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
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}