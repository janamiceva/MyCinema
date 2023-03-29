import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/cinema_bloc.dart';
import '../widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'location_screen.dart';

class DetailsPaymentPage extends StatefulWidget {
  @override
  State<DetailsPaymentPage> createState() => _DetailsPaymentPageState();
}

class _DetailsPaymentPageState extends State<DetailsPaymentPage> {

  @override
  void initState() {
    super.initState();
    // Call your function here
    Future.delayed(Duration.zero, () async {
      await savePaymentDetails();
    });

  }
  
  Future<void> savePaymentDetails() async {
    final cinemabloc = BlocProvider.of<CinemaBloc>(context);
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User user = auth.currentUser;
  if(user == null){
        print('No user authenticated!');
  }
  final email = user.email;
  if (email == null) {
    // handle the case when the user is not authenticated
    print('No user authenticated!');
}
  final paymentDetails = {
    'date': cinemabloc.state.date,
    'selectedSeats': cinemabloc.state.selectedSeats,
    'time': cinemabloc.state.time,
    'tickets': cinemabloc.state.selectedSeats.length,
    'image': cinemabloc.state.imageMovie,
  };
  await FirebaseFirestore
    .instance
    .collection('users')
    .doc(user.uid)
    .collection(
        'tickets')
    .add(paymentDetails);
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cinemabloc = BlocProvider.of<CinemaBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xffba68c8),
      appBar: AppBar(
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
              'MyCinema',
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
      body: SafeArea(
                child: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    Container(
                      height: size.height * .45,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(15.0)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(cinemabloc.state.imageMovie))),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              TextFrave(
                                  text: 'DATE',
                                  color: Colors.grey,
                                  fontSize: 16),
                              TextFrave(text: cinemabloc.state.date),
                            ],
                          ),
                          Column(
                            children: [
                              TextFrave(
                                  text: 'TICKETS',
                                  color: Colors.grey,
                                  fontSize: 16),
                              TextFrave(
                                  text:
                                      '${cinemabloc.state.selectedSeats.length}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              TextFrave(
                                  text: 'TIME',
                                  color: Colors.grey,
                                  fontSize: 16),
                              TextFrave(text: cinemabloc.state.time),
                            ],
                          ),
                          Column(
                            children: [
                              TextFrave(
                                  text: 'SEATS',
                                  color: Colors.grey,
                                  fontSize: 16),
                              Row(
                                children: List.generate(
                                    cinemabloc.state.selectedSeats.length, (i) {
                                  return TextFrave(
                                      text:
                                          '${cinemabloc.state.selectedSeats[i]} ');
                                }),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(31,
                          (index) => TextFrave(text: '- ', color: Colors.grey)),
                    ),
                    SizedBox(height: 10.0),
                    SizedBox(
                      height: 120,
                      width: 120,
                      child: Image(image: AssetImage('images/qrcode.png')),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                top: size.height * .695,
                left: 15,
                child: Icon(Icons.circle, color: Color(0xff21242C))),
            Positioned(
                top: size.height * .695,
                right: 15,
                child: Icon(Icons.circle, color: Color(0xff21242C))),
          ],
        ),
      ),
      ),
    );
  }
}