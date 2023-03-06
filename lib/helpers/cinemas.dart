import '../screens/cineplexx_review_screen.dart';
import '../screens/milenium_review_screen.dart';

class Data {
  List cinemas = [
    {
      "name": "Cineplexx",
      "navigate": CineplexxReviewScreen(),
      "lat": 42.0049214389,
      "lng": 21.3924407959,
      "distance": 0,
    },
    {
      "name": "Kino Milenium",
      "navigate": MileniumReviewScreen(),
      "lat": 41.9942401867,
      "lng": 21.4357065799,
      "distance": 0,
    },
  ];
}
