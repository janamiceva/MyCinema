import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../helpers/components.dart';
import 'details_payment_page.dart';
import 'home_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade700,
        leading: Icon(Icons.arrow_back, color: Colors.white, size: 20),
        elevation: 4,
        actions: [
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 10,
            width: 200,
            child: Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Icon(Icons.location_on),
          SizedBox(width: 15.0),
        ],
      ),
      body: Body(),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple.shade300, Colors.pink.shade100])),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          child: GNav(
            backgroundColor: Colors.transparent,
            color: Colors.white,
            activeColor: Colors.white,
            padding: EdgeInsets.all(10),
            tabs:  [
              GButton(
                icon: Icons.home,
                text: 'Home',
                onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
              },  
              ),
              GButton(
                icon: Icons.search,
                text: 'Search', 
              ),
              GButton(
                icon: Icons.view_module_rounded,
                text: 'Location', 
              ),
              GButton(
                icon: Icons.local_attraction_rounded,
                text: 'Tickets',
                onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailsPaymentPage()));
              },         
              ),
              GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
                onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen()));
              },  
              ),
            ],
          ),
        ),
      ),
    );
  }
}