import 'package:flutter/material.dart';

import '../widgets/widgets.dart';
import 'profile_menu.dart';
import 'profile_picture.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePicture(),
          SizedBox(height: 20),
          TextFrave(
                text: "Maddy",
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500),
          TextFrave(
                text: "@maddy1999",
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w100),
          ProfileMenu(
            text: "Edit Profile",
            icon: "images/profile.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "My Movie Pass",
            icon: "images/tickets.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Notification",
            icon: "images/bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "images/settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help",
            icon: "images/info.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "images/logout.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}