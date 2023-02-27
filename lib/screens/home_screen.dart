import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mycinema/screens/details_payment_screen.dart';
import '../models/movie_model.dart';
import '../models/trailers_model.dart';
import 'details_movie_screen.dart';
import '../widgets/widgets.dart';
import '../screens/profile_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../helpers/search_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        leading: Icon(Icons.arrow_back, color: Colors.white, size: 20),
        elevation: 4,
        actions: [
          Container(
            padding: EdgeInsets.only(top: 20),
            height: 10,
            width: 200,
            child: Text(
              'MyCinema',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Icon(Icons.location_on),
          SizedBox(width: 15.0),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue.shade700, Colors.purple.shade600])),
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          children: [
            _ItemTitle(title: 'Trailes'),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              height: 200,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: TrailersMovie.listTrailers.length,
                  itemBuilder: (context, i) =>
                      _ItemTrailers(trailers: TrailersMovie.listTrailers[i])),
            ),
            SizedBox(height: 20.0),
            _ItemTitle(title: 'Now Showing'),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              height: 280,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: MovieModel.listMovie.length,
                itemBuilder: (context, i) =>
                    _ItemsNowCinemas(movieModel: MovieModel.listMovie[i]),
              ),
            ),
            SizedBox(height: 20.0),
            _ItemTitle(title: 'Coming Soon'),
            Container(
              margin: EdgeInsets.only(left: 20.0),
              height: 280,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, i) =>
                    _ItemsSoonMovie(movieModel: MovieModel.listMovie[i + 2]),
              ),
            ),
          ],
        ),
      ),
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
            tabs: [
              GButton(
                icon: Icons.home,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemsSoonMovie extends StatelessWidget {
  final MovieModel movieModel;

  const _ItemsSoonMovie({Key key, this.movieModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 210,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(movieModel.image))),
            ),
            SizedBox(height: 15.0),
            SizedBox(
              width: 160,
              child: TextFrave(text: movieModel.name, color: Colors.white),
            ),
            SizedBox(height: 5.0),
            RatingBar.builder(
                itemSize: 22,
                initialRating: movieModel.qualification,
                itemBuilder: (_, i) =>
                    Icon(Icons.star_rate_rounded, color: Colors.amber),
                onRatingUpdate: (_) {})
          ],
        ),
      ),
    );
  }
}

class _ItemsNowCinemas extends StatelessWidget {
  final MovieModel movieModel;

  const _ItemsNowCinemas({Key key, this.movieModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => DetailsMoviePage(movieModel: movieModel))),
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'movie-hero-${movieModel.id}',
              child: Container(
                height: 210,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(movieModel.image))),
              ),
            ),
            SizedBox(height: 15.0),
            SizedBox(
              width: 160,
              child: TextFrave(text: movieModel.name, color: Colors.white),
            ),
            SizedBox(height: 5.0),
            RatingBar.builder(
                itemSize: 22,
                initialRating: movieModel.qualification,
                itemBuilder: (_, i) =>
                    Icon(Icons.star_rate_rounded, color: Colors.amber),
                onRatingUpdate: (_) {})
          ],
        ),
      ),
    );
  }
}

class _ItemTitle extends StatelessWidget {
  final String title;

  const _ItemTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFrave(
                text: title,
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ],
        ),
      ),
    );
  }
}

class _ItemTrailers extends StatelessWidget {
  final TrailersMovie trailers;

  const _ItemTrailers({Key key, this.trailers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Stack(
        children: [
          Container(
            width: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(trailers.image))),
          ),
          Container(
            width: 300,
            child: Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 10.0,
                  sigmaY: 10.0,
                ),
                child: Container(
                    padding: EdgeInsets.all(15),
                    color: Colors.white.withOpacity(0.3),
                    child: Icon(Icons.play_arrow_rounded,
                        color: Colors.white, size: 45)),
              ),
            )),
          )
        ],
      ),
    );
  }
}
