import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../helpers/components.dart';
import 'details_payment_screen.dart';
import 'home_screen.dart';
import '../helpers/search_bar.dart';
import 'location_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade300, Colors.pink.shade100],
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.purple.shade300,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 20),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
              elevation: 4,
              title: Center(
                child: Text(
                  'Profile',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LocationScreen()),
                    );
                  },
                  icon: Icon(Icons.location_pin),
                ),
                SizedBox(width: 15.0),
              ],
            ),
            Expanded(child: Body()),
            Container(
              height: 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.purple.shade300, Colors.pink.shade100])),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                child: GNav(
                  backgroundColor: Colors.transparent,
                  color: Colors.white,
                  activeColor: Colors.white,
                  padding: EdgeInsets.all(10),
                  tabs: [
                    GButton(
                      icon: Icons.home,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => HomeScreen()));
                      },
                    ),
                    GButton(
                      icon: Icons.search,
                      onPressed: () {
                        // method to show the search bar
                        showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate());
                      },
                    ),
                    GButton(
                      icon: Icons.view_module_rounded,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LocationScreen()));
                      },
                    ),
                    GButton(
                      icon: Icons.local_attraction_rounded,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailsPaymentPage()));
                      },
                    ),
                    GButton(
                      icon: Icons.person_rounded,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
