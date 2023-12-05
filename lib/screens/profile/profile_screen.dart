import 'package:flutter/material.dart';

import '../../authentication.dart';
import '../add_product/add_product_screen.dart';
import 'components/profile_menu.dart';
import 'components/profile_pic.dart';
import '../sign_in/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";

  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Add product",
              icon: "assets/icons/Add Icon.svg",
              press: () =>
                  {Navigator.pushNamed(context, AddProductScreen.routeName)},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () async {
                await Authentication.signOut(context: context);
                Future.delayed(Duration.zero, () {
                  Navigator.pushNamed(context, SignInScreen.routeName);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
