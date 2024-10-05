import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:project8/constants/app_constants.dart';
import 'package:project8/data_layers/auth_layer.dart';
import 'package:project8/extensions/screen_nav.dart';
import 'package:project8/screens/auth_screens/login_screen.dart';
import 'package:project8/widgets/cards/profile_card.dart';
import 'package:project8/widgets/texts/category_title.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = GetIt.I.get<AuthLayer>().customer;
    return Scaffold(
      backgroundColor: AppConstants.mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset("assets/images/default_profile_img.png",fit: BoxFit.cover),
                    ),
                    Text("Take a coffee & give me\n something",style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppConstants.subTextColor)),
                  ],
                ),
                const SizedBox(height: 20),
                GetIt.I.get<AuthLayer>().isGuest() == false
                ? Column(
                    children: [
                      const CategoryTitle(title: "Information"),
                      ProfileCard(title: profile!.name, icon: HugeIcons.strokeRoundedUser),
                      ProfileCard(title: profile.email, icon: HugeIcons.strokeRoundedMail01),
                      ProfileCard(title: profile.phoneNumber,icon: HugeIcons.strokeRoundedSmartPhone01),
                    ],
                  )
                : const SizedBox.shrink(),
                const SizedBox(height: 20),
                const CategoryTitle(title: "Settings"),
                ProfileCard(
                  title: "Contact us",
                  icon: Icons.link,
                  onTap: () async {
                    if (!await launchUrl(Uri.parse("https://linktr.ee/Onzecafe11"))) {
                      throw Exception('Could not launch link');
                    }
                  }
                ),
                const ProfileCard(title: "Q&A", icon: HugeIcons.strokeRoundedMessageQuestion),
                const ProfileCard(title: "Dark mode", icon: HugeIcons.strokeRoundedMoon02),
                const SizedBox(height: 20),
                GetIt.I.get<AuthLayer>().isGuest() == false
                ? TextButton.icon(
                    label: Text("Logout",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppConstants.mainRed),),
                    icon: const Icon(Icons.power_settings_new,color: AppConstants.mainRed, size: 30),
                    style: const ButtonStyle(
                      overlayColor: WidgetStateColor.transparent,
                      padding: WidgetStatePropertyAll(EdgeInsets.only(top: 8))
                    ),
                    onPressed: () {
                      GetIt.I.get<AuthLayer>().customer = null;
                      GetIt.I.get<AuthLayer>().box.erase();
                      OneSignal.logout();
                      context.pushRemove(screen: const LoginScreen());
                    },
                  )
                  : Column(
                    children: [
                      const SizedBox(height: 70),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 45),
                          backgroundColor: AppConstants.mainBlue,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                        )
                      ),
                      onPressed: ()=> context.pushRemove(screen: const LoginScreen()),
                      child: Text("Login",style: Theme.of(context).textTheme.titleLarge!.copyWith(color: AppConstants.mainWhite),)
                    ),
                  ],
                ),
                const SizedBox(height: 70)
              ],
            ),
          ),
        ),
      ),
    );
  }
}