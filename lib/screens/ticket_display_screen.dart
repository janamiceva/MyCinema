import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/cinema_bloc.dart';
import '../widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'location_screen.dart';




class TicketDisplayPage extends StatefulWidget {
  @override
  State<TicketDisplayPage> createState() => _TicketDisplayPageState();
}

class _TicketDisplayPageState extends State<TicketDisplayPage> {
  Map<String, dynamic> latestTicket = {};

  @override
  void initState() {
    super.initState();
    // Call your function here
    Future.delayed(Duration.zero, () async {
      await getTickets();
    });
  }
  
  Future<void> getTickets() async{
    final currentUser = FirebaseAuth.instance.currentUser;
final email = currentUser.email;
if (email == null) {
  print('Error');
}
final querySnapshot = await FirebaseFirestore.instance
  .collection('users')
  .doc(FirebaseAuth.instance.currentUser.uid)
  .collection('tickets')
  .orderBy('date', descending: true)
  .limit(1)
  .get();
setState(() {
      if (querySnapshot.docs.isNotEmpty) {
        latestTicket = querySnapshot.docs.first.data();
      } else {
        latestTicket = null;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cinemabloc = BlocProvider.of<CinemaBloc>(context);
    
if (latestTicket == null) {
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
      body: Center(
        child: Text('No tickets found.',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,)),
      ),
    );
  }
  else
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
                              image: AssetImage(latestTicket['image']))),
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
                                  text: 'DATE:',
                                  color: Colors.grey,
                                  fontSize: 16),
                              TextFrave(text: latestTicket['date']),
                            ],
                          ),
                          Column(
                            children: [
                              TextFrave(
                                  text: 'TICKETS',
                                  color: Colors.grey,
                                  fontSize: 16),
                              TextFrave(
                                text: latestTicket['tickets'],
                                )
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
                                  text: 'TIME: ',
                                  color: Colors.grey,
                                  fontSize: 16),
                              TextFrave(text: latestTicket['time']),
                            ],
                          ),
                          Column(
                            children: [
                              TextFrave(
                                  text: 'SEATS:',
                                  color: Colors.grey,
                                  fontSize: 16),
                              Row(
                                children: List.generate(
                                    latestTicket['selectedSeats'].length, (i) {
                                  return TextFrave(
                                      text:
                                          '${latestTicket['selectedSeats']}');
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